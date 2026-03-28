#!/usr/bin/env bash
# SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

set -euo pipefail

TARGET_OPENCLAW_HOME="${HOME}/.openclaw"
TARGET_SHARED_SKILLS="${TARGET_OPENCLAW_HOME}/skills"
TARGET_WORKSPACE="${OPENCLAW_WORKSPACE_DIR:-${TARGET_OPENCLAW_HOME}/workspace}"

ok() {
  printf '[melva-verify] OK: %s\n' "$*"
}

warn() {
  printf '[melva-verify] WARN: %s\n' "$*" >&2
}

check_file() {
  local path="$1"
  if [[ -f "${path}" ]]; then
    ok "${path}"
  else
    warn "Missing file: ${path}"
  fi
}

check_dir() {
  local path="$1"
  if [[ -d "${path}" ]]; then
    ok "${path}"
  else
    warn "Missing dir: ${path}"
  fi
}

check_bin() {
  local name="$1"
  if command -v "${name}" >/dev/null 2>&1; then
    ok "binary ${name} -> $(command -v "${name}")"
  else
    warn "Missing binary: ${name}"
  fi
}

main() {
  check_dir "${TARGET_WORKSPACE}"
  check_file "${TARGET_WORKSPACE}/AGENTS.md"
  check_file "${TARGET_WORKSPACE}/BOOTSTRAP.md"
  check_file "${TARGET_WORKSPACE}/SOUL.md"
  check_file "${TARGET_WORKSPACE}/TOOLS.md"
  check_file "${TARGET_WORKSPACE}/IDENTITY.md"
  check_file "${TARGET_WORKSPACE}/USER.md"

  check_dir "${TARGET_SHARED_SKILLS}"
  check_file "${TARGET_SHARED_SKILLS}/agentmail/SKILL.md"
  check_file "${TARGET_SHARED_SKILLS}/self-improvement/SKILL.md"
  check_file "${TARGET_SHARED_SKILLS}/supermemory/SKILL.md"

  for bin in clawhub gh tmux mcporter jq rg ffmpeg summarize nano-pdf himalaya gifgrep claude codex; do
    check_bin "${bin}"
  done
}

main "$@"
