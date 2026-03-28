#!/usr/bin/env bash
# SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

set -euo pipefail

TARGET_OPENCLAW_HOME="${HOME}/.openclaw"
BASE_WORKSPACE="${OPENCLAW_WORKSPACE_DIR:-${TARGET_OPENCLAW_HOME}/workspace}"
OVERWRITE="${MELVA_OVERWRITE:-0}"

log() {
  printf '[melva-workspaces] %s\n' "$*"
}

write_identity() {
  local dir="$1"
  local display_name="$2"
  local creature="$3"
  local vibe="$4"
  local emoji="$5"

  cat > "${dir}/IDENTITY.md" <<EOF
# IDENTITY.md - Who Am I?

- **Name:** ${display_name}
- **Creature:** ${creature}
- **Vibe:** ${vibe}
- **Emoji:** ${emoji}
- **Avatar:**

---

MELVA multi-agent workspace identity file.
EOF
}

seed_workspace() {
  local workspace_name="$1"
  local display_name="$2"
  local creature="$3"
  local vibe="$4"
  local emoji="$5"
  local dir="${TARGET_OPENCLAW_HOME}/${workspace_name}"

  if [[ -e "${dir}" && "${OVERWRITE}" != "1" ]]; then
    log "Skipping existing ${dir}"
    return 0
  fi

  rm -rf "${dir}"
  mkdir -p "${dir}"
  cp -r "${BASE_WORKSPACE}/." "${dir}/"
  mkdir -p "${dir}/memory"
  write_identity "${dir}" "${display_name}" "${creature}" "${vibe}" "${emoji}"
  log "Seeded ${dir}"
}

main() {
  if [[ ! -d "${BASE_WORKSPACE}" ]]; then
    printf '[melva-workspaces] Missing base workspace: %s\n' "${BASE_WORKSPACE}" >&2
    exit 1
  fi

  seed_workspace "workspace-sales" "Säljchef" "AI sales lead" "commercial, sharp, decisive" "💼"
  seed_workspace "workspace-prospector" "Prospekterare" "AI prospector" "focused, efficient, persistent" "🎯"
  seed_workspace "workspace-researcher" "Researcher" "AI sales researcher" "curious, rigorous, analytical" "🔎"
  seed_workspace "workspace-copywriter" "Copywriter" "AI copy specialist" "persuasive, crisp, adaptive" "✍️"
  seed_workspace "workspace-strategist" "Strateg" "AI pipeline strategist" "calm, strategic, high-leverage" "♟️"
  seed_workspace "workspace-engineering" "Teknikchef" "AI engineering lead" "technical, pragmatic, exact" "🛠️"
  seed_workspace "workspace-delivery" "Leveranschef" "AI delivery lead" "structured, reliable, coordinating" "📦"
  seed_workspace "workspace-voicearchitect" "Röstarkitekt" "AI voice architect" "iterative, precise, conversion-aware" "🎙️"
  seed_workspace "workspace-customersuccess" "Kundansvarig" "AI customer success lead" "attentive, steady, retention-focused" "🤝"
  seed_workspace "workspace-operations" "Driftchef" "AI operations lead" "systematic, disciplined, dependable" "📊"
  seed_workspace "workspace-intelligence" "Omvärldsanalytiker" "AI intelligence analyst" "watchful, synthesis-driven, skeptical" "🧠"
  seed_workspace "workspace-automation" "Automationschef" "AI automation lead" "cross-functional, optimizing, proactive" "⚙️"
  seed_workspace "workspace-systembuilder" "Systembyggare" "AI systems builder" "builder-minded, modular, execution-focused" "🔧"
}

main "$@"
