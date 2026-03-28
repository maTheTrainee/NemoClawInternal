#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
config_path="${MELVA_LITELLM_CONFIG:-$repo_root/melva/config/litellm.config.yaml}"
host="${MELVA_LITELLM_HOST:-127.0.0.1}"
port="${MELVA_LITELLM_PORT:-4000}"
env_file="${MELVA_LITELLM_ENV_FILE:-$repo_root/melva/config/litellm.env}"

if ! command -v litellm >/dev/null 2>&1; then
  echo "litellm is not installed"
  exit 1
fi

if [ ! -f "$config_path" ]; then
  echo "LiteLLM config not found: $config_path"
  exit 1
fi

if [ -f "$env_file" ]; then
  set -a
  # shellcheck disable=SC1090
  . "$env_file"
  set +a
fi

if [ -z "${LITELLM_MASTER_KEY:-}" ]; then
  if [ -n "${COMPATIBLE_API_KEY:-}" ]; then
    export LITELLM_MASTER_KEY="$COMPATIBLE_API_KEY"
  else
    echo "Set LITELLM_MASTER_KEY or COMPATIBLE_API_KEY before starting LiteLLM"
    exit 1
  fi
fi

# LiteLLM 1.82 on Python 3.14 hardcodes uvloop in proxy_cli, which crashes
# before the server binds. Patch it to asyncio at startup until upstream fixes it.
python3 - <<'PY'
from pathlib import Path
p = Path.home() / ".local/lib/python3.14/site-packages/litellm/proxy/proxy_cli.py"
if p.exists():
    text = p.read_text()
    if 'return "uvloop"' in text:
        p.write_text(text.replace('return "uvloop"', 'return "asyncio"', 1))
PY

exec litellm --host "$host" --port "$port" --config "$config_path"
