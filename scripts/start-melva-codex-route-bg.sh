#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
log_file="${MELVA_CODEX_LOG_FILE:-$HOME/melva-codex-bridge.log}"

setsid bash "$repo_root/scripts/start-melva-codex-bridge.sh" >"$log_file" 2>&1 < /dev/null &

echo "Started MELVA Codex bridge in background"
echo "Log: $log_file"
