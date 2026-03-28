#!/usr/bin/env bash
# SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")/.." && pwd)"
MELVA_ROOT="${REPO_ROOT}/melva"
TARGET_OPENCLAW_HOME="${HOME}/.openclaw"
TARGET_SHARED_SKILLS="${TARGET_OPENCLAW_HOME}/skills"
TARGET_WORKSPACE_DEFAULT="${TARGET_OPENCLAW_HOME}/workspace"
TARGET_WORKSPACE="${OPENCLAW_WORKSPACE_DIR:-${TARGET_WORKSPACE_DEFAULT}}"

log() {
  printf '[melva-install] %s\n' "$*"
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1
}

install_npm_tools() {
  if need_cmd npm; then
    local missing=()
    for bin in clawhub mcporter summarize; do
      if ! need_cmd "${bin}"; then
        missing+=("${bin}")
      fi
    done
    if [[ "${#missing[@]}" -gt 0 ]]; then
      log "Installing npm-based CLIs: clawhub mcporter @steipete/summarize"
      npm install -g clawhub mcporter @steipete/summarize
    fi
  else
    log "Skipping npm-based CLI install because npm is missing"
  fi
}

install_uv_tools() {
  if need_cmd uv; then
    if ! need_cmd nano-pdf; then
      log "Installing nano-pdf with uv"
      uv tool install nano-pdf
    fi
  else
    log "Skipping nano-pdf install because uv is missing"
  fi
}

install_himalaya() {
  if need_cmd himalaya; then
    return 0
  fi
  if need_cmd curl; then
    log "Installing himalaya to ~/.local/bin"
    curl -sSL https://raw.githubusercontent.com/pimalaya/himalaya/master/install.sh | PREFIX="${HOME}/.local" sh
  else
    log "Skipping himalaya install because curl is missing"
  fi
}

install_gifgrep() {
  if need_cmd gifgrep; then
    return 0
  fi
  if ! need_cmd curl || ! need_cmd python3; then
    log "Skipping gifgrep install because curl or python3 is missing"
    return 0
  fi

  local go_root="${HOME}/.local/go-toolchain/go"
  local go_bin="${go_root}/bin/go"
  if [[ ! -x "${go_bin}" ]]; then
    log "Installing local Go toolchain for gifgrep"
    mkdir -p "${HOME}/.local/go-toolchain"
    cd "${HOME}/.local/go-toolchain"
    local go_url
    go_url="$(python3 - <<'PY'
import json, urllib.request
releases=json.load(urllib.request.urlopen('https://go.dev/dl/?mode=json'))
for rel in releases:
    for f in rel.get('files', []):
        if f.get('os') == 'linux' and f.get('arch') == 'amd64' and f.get('kind') == 'archive':
            print('https://go.dev/dl/' + f['filename'])
            raise SystemExit
PY
)"
    curl -fsSLO "${go_url}"
    tar -xzf "$(basename "${go_url}")"
  fi

  log "Installing gifgrep to ~/.local/bin"
  GOROOT="${go_root}" GOPATH="${HOME}/.local/go" GOBIN="${HOME}/.local/bin" "${go_bin}" install github.com/steipete/gifgrep/cmd/gifgrep@latest
}

copy_workspace_base() {
  mkdir -p "${TARGET_WORKSPACE}"
  cp -r "${MELVA_ROOT}/workspace-base/." "${TARGET_WORKSPACE}/"
  log "Copied workspace base to ${TARGET_WORKSPACE}"
}

copy_shared_skills() {
  mkdir -p "${TARGET_SHARED_SKILLS}"
  cp -r "${MELVA_ROOT}/shared-skills/." "${TARGET_SHARED_SKILLS}/"
  log "Copied shared skills to ${TARGET_SHARED_SKILLS}"
}

copy_config_examples() {
  mkdir -p "${TARGET_OPENCLAW_HOME}"
  cp "${MELVA_ROOT}/config/env.example" "${TARGET_OPENCLAW_HOME}/env.example"
  cp "${MELVA_ROOT}/config/openclaw.example.json" "${TARGET_OPENCLAW_HOME}/openclaw.example.json"
  log "Copied example config to ${TARGET_OPENCLAW_HOME}"
}

main() {
  log "Repo root: ${REPO_ROOT}"
  log "Target workspace: ${TARGET_WORKSPACE}"
  install_npm_tools
  install_uv_tools
  install_himalaya
  install_gifgrep
  copy_workspace_base
  log "Seeding MELVA team workspaces"
  bash "${REPO_ROOT}/scripts/setup-melva-workspaces.sh"
  copy_shared_skills
  copy_config_examples
  log "Direct Codex route available via scripts/start-melva-codex-route.sh and scripts/activate-melva-codex-route.sh"
  log "Running MELVA verification"
  bash "${REPO_ROOT}/scripts/verify-melva.sh"
  log "Done"
}

main "$@"
