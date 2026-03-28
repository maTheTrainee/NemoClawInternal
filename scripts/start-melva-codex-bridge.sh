#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
env_file="${MELVA_CODEX_ENV_FILE:-${MELVA_LITELLM_ENV_FILE:-$repo_root/melva/config/litellm.env}}"

if [ -f "$env_file" ]; then
  set -a
  # shellcheck disable=SC1090
  . "$env_file"
  set +a
fi

if [ -z "${CODEX_BRIDGE_KEY:-}" ]; then
  if [ -n "${COMPATIBLE_API_KEY:-}" ]; then
    export CODEX_BRIDGE_KEY="$COMPATIBLE_API_KEY"
  elif [ -n "${OPENAI_API_KEY:-}" ]; then
    export CODEX_BRIDGE_KEY="$OPENAI_API_KEY"
  else
    echo "Set CODEX_BRIDGE_KEY or COMPATIBLE_API_KEY in $env_file or the environment"
    exit 1
  fi
fi

exec python3 "$repo_root/scripts/codex_openai_bridge.py"
