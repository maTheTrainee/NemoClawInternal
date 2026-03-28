# MELVA Codex Route

This setup makes the local Codex bridge the default MELVA inference path for NemoClaw/OpenShell without changing the MELVA agent structure.

## Files

- `melva/config/litellm.env.example`
- `scripts/codex_openai_bridge.py`
- `scripts/start-melva-codex-bridge.sh`
- `scripts/start-melva-codex-route.sh`
- `scripts/start-melva-codex-route-bg.sh`
- `scripts/setup-melva-codex-direct-route.sh`
- `scripts/activate-melva-codex-route.sh`
- `melva/config/litellm.config.yaml`
- `scripts/start-melva-litellm.sh`
- `scripts/setup-melva-litellm-route.sh`

## What It Does

1. Starts a local Codex bridge on `127.0.0.1:4141`
2. Registers an OpenShell provider named `compatible-endpoint`
3. Points that provider to `http://127.0.0.1:4141/v1`
4. Switches the live inference route to `openai-codex/gpt-5.3-codex`
5. Uses the already authenticated local Codex CLI as the real upstream

LiteLLM remains available as a fallback layer, but it is no longer the recommended or default MELVA route.

## Why This Path Exists

NemoClaw already supports `compatible-endpoint` as an OpenAI-compatible provider. The direct bridge is the cleanest path because it avoids trying to reconstruct Codex HTTP internals and reuses the working local `codex` login directly.

The Codex bridge exists because the upstream auth is owned by the locally authenticated Codex CLI, not by OpenShell. OpenShell only needs a local OpenAI-compatible endpoint.

## Default Values

- Provider name: `compatible-endpoint`
- Base URL: `http://127.0.0.1:4141/v1`
- Model: `openai-codex/gpt-5.3-codex`
- Credential env: `CODEX_BRIDGE_KEY`
- Codex bridge URL: `http://127.0.0.1:4141/v1`

## Auth Model

- `CODEX_BRIDGE_KEY` is the credential OpenShell sends to the local Codex bridge.
- The Codex bridge uses the locally authenticated Codex CLI as its upstream.
- `COMPATIBLE_API_KEY` and `LITELLM_MASTER_KEY` are only needed if you intentionally keep LiteLLM in the path as a fallback.

## Recommended Setup

1. Copy `melva/config/litellm.env.example` to `melva/config/litellm.env`
2. Set `CODEX_BRIDGE_KEY`
3. Optionally set `CODEX_BRIDGE_MODEL` if you want a different visible model alias
4. Start the bridge with `bash scripts/start-melva-codex-route.sh`
   or detached with `bash scripts/start-melva-codex-route-bg.sh`
5. Activate the route with `bash scripts/activate-melva-codex-route.sh`

## LiteLLM Fallback

Use the LiteLLM files only if you explicitly want an extra local proxy hop:

1. Start the Codex bridge
2. Start LiteLLM
3. Run `bash scripts/setup-melva-litellm-route.sh`
