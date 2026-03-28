#!/usr/bin/env python3

import json
import os
import subprocess
import tempfile
import time
import uuid
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path


HOST = os.environ.get("CODEX_BRIDGE_HOST", "127.0.0.1")
PORT = int(os.environ.get("CODEX_BRIDGE_PORT", "4141"))
MODEL_NAME = os.environ.get("CODEX_BRIDGE_MODEL", "openai-codex/gpt-5.3-codex")
AUTH_KEY = os.environ.get("CODEX_BRIDGE_KEY", "")
EXTRA_ARGS = os.environ.get("CODEX_EXEC_EXTRA_ARGS", "").split()
TIMEOUT = int(os.environ.get("CODEX_EXEC_TIMEOUT_SECONDS", "180"))
WORKDIR = os.environ.get("CODEX_EXEC_CD", str(Path(__file__).resolve().parents[1]))


def json_response(handler, status, payload):
    body = json.dumps(payload).encode("utf-8")
    handler.send_response(status)
    handler.send_header("Content-Type", "application/json")
    handler.send_header("Content-Length", str(len(body)))
    handler.end_headers()
    handler.wfile.write(body)


def extract_prompt(messages):
    lines = []
    for message in messages or []:
      role = message.get("role", "user")
      content = message.get("content", "")
      if isinstance(content, list):
          parts = []
          for item in content:
              if isinstance(item, dict) and item.get("type") == "text":
                  parts.append(item.get("text", ""))
          content = "\n".join(part for part in parts if part)
      lines.append(f"{role.upper()}:\n{content}".strip())
    return "\n\n".join(line for line in lines if line).strip()


def run_codex(prompt):
    with tempfile.NamedTemporaryFile(prefix="codex-bridge-", suffix=".txt", delete=False) as fh:
        output_path = fh.name

    try:
        cmd = ["codex", "exec", "-C", WORKDIR, "-o", output_path, prompt, *EXTRA_ARGS]
        proc = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            timeout=TIMEOUT,
            env=os.environ.copy(),
        )
        stdout = (proc.stdout or "").strip()
        stderr = (proc.stderr or "").strip()
        if proc.returncode != 0:
            raise RuntimeError(stderr or stdout or f"codex exited with {proc.returncode}")

        try:
            text = Path(output_path).read_text().strip()
        except OSError:
            text = ""

        return text or stdout or stderr or " "
    finally:
        try:
            os.unlink(output_path)
        except OSError:
            pass


class Handler(BaseHTTPRequestHandler):
    server_version = "CodexBridge/0.1"

    def _authorized(self):
        if not AUTH_KEY:
            return True
        auth = self.headers.get("Authorization", "")
        return auth == f"Bearer {AUTH_KEY}"

    def _read_json(self):
        length = int(self.headers.get("Content-Length", "0"))
        raw = self.rfile.read(length) if length else b"{}"
        return json.loads(raw.decode("utf-8"))

    def do_GET(self):
        if self.path == "/health":
            return json_response(self, 200, {"ok": True, "model": MODEL_NAME})
        if self.path == "/v1/models":
            return json_response(
                self,
                200,
                {
                    "object": "list",
                    "data": [{"id": MODEL_NAME, "object": "model", "owned_by": "codex-bridge"}],
                },
            )
        return json_response(self, 404, {"error": {"message": "Not found"}})

    def do_POST(self):
        if not self._authorized():
            return json_response(self, 401, {"error": {"message": "Unauthorized"}})
        if self.path != "/v1/chat/completions":
            return json_response(self, 404, {"error": {"message": "Not found"}})

        try:
            payload = self._read_json()
            requested_model = payload.get("model") or MODEL_NAME
            prompt = extract_prompt(payload.get("messages", []))
            if not prompt:
                return json_response(self, 400, {"error": {"message": "No prompt provided"}})
            content = run_codex(prompt)
        except subprocess.TimeoutExpired:
            return json_response(self, 504, {"error": {"message": "Codex timed out"}})
        except Exception as exc:
            return json_response(self, 500, {"error": {"message": str(exc)}})

        completion_id = f"chatcmpl-{uuid.uuid4().hex}"
        created = int(time.time())
        return json_response(
            self,
            200,
            {
                "id": completion_id,
                "object": "chat.completion",
                "created": created,
                "model": requested_model,
                "choices": [
                    {
                        "index": 0,
                        "finish_reason": "stop",
                        "message": {"role": "assistant", "content": content},
                    }
                ],
                "usage": {"prompt_tokens": 0, "completion_tokens": 0, "total_tokens": 0},
            },
        )

    def log_message(self, fmt, *args):
        return


if __name__ == "__main__":
    server = ThreadingHTTPServer((HOST, PORT), Handler)
    print(f"Codex bridge listening on http://{HOST}:{PORT}/v1")
    server.serve_forever()
