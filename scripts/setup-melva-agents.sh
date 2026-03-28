#!/usr/bin/env bash

set -euo pipefail

agent_root="${MELVA_AGENT_ROOT:-$HOME/.openclaw/agents}"
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$agent_root"

write_agent() {
  local id="$1"
  local name="$2"
  local role="$3"
  local team="$4"
  local workspace="$5"
  local contacts="$6"
  local dir="$agent_root/$id"

  mkdir -p "$dir"

  cat > "$dir/AGENT_CARD.md" <<EOF
# $name

## Agent ID
$id

## Role
$role

## Team
$team

## Workspace
$workspace

## Provider
codex

## Allowed Contacts
$contacts

## Operating Rule
- This agent is a persistent first-class MELVA agent.
- Use the assigned workspace as the primary durable working area.
- In NemoClaw mode, this agent runs on the shared codex provider.
- Coordinate through the allowed contacts list instead of assuming universal access.
EOF

  cat > "$dir/CONTACTS.md" <<EOF
# Allowed Contacts

$contacts
EOF
}

write_agent "melva" "MELVA" "Executive orchestration and system leadership" "core" "workspace" "- sales
- engineering
- delivery
- customersuccess
- operations
- intelligence
- automation"

write_agent "sales" "Sales Team" "Revenue coordination and outbound execution" "sales" "workspace-sales" "- melva
- prospector
- researcher
- copywriter
- strategist
- delivery
- customersuccess
- intelligence"

write_agent "prospector" "Prospector" "Lead sourcing and qualification" "sales" "workspace-prospector" "- sales
- researcher
- strategist"

write_agent "researcher" "Researcher" "Account, market, and evidence research" "sales" "workspace-researcher" "- sales
- prospector
- copywriter
- strategist
- intelligence
- engineering"

write_agent "copywriter" "Copywriter" "Outbound and offer messaging" "sales" "workspace-copywriter" "- sales
- researcher
- strategist"

write_agent "strategist" "Strategist" "Commercial planning and prioritization" "sales" "workspace-strategist" "- sales
- prospector
- researcher
- copywriter
- melva
- intelligence
- delivery"

write_agent "engineering" "Engineering" "Systems, integrations, and implementation" "core" "workspace-engineering" "- melva
- researcher
- delivery
- voicearchitect
- automation
- systembuilder
- intelligence"

write_agent "delivery" "Delivery" "Client execution and handoff coordination" "core" "workspace-delivery" "- melva
- sales
- strategist
- engineering
- voicearchitect
- customersuccess
- operations"

write_agent "voicearchitect" "Voice Architect" "Voice and conversational experience design" "delivery" "workspace-voicearchitect" "- delivery
- engineering
- customersuccess"

write_agent "customersuccess" "Customer Success" "Customer retention and outcome protection" "core" "workspace-customersuccess" "- melva
- sales
- delivery
- voicearchitect
- operations
- intelligence"

write_agent "operations" "Operations" "Process, cadence, and operating stability" "core" "workspace-operations" "- melva
- delivery
- customersuccess
- intelligence
- automation
- systembuilder"

write_agent "intelligence" "Intelligence" "Cross-team memory, synthesis, and insight" "core" "workspace-intelligence" "- melva
- sales
- researcher
- strategist
- engineering
- customersuccess
- operations
- automation"

write_agent "automation" "Automation" "Workflow automation and orchestration plumbing" "core" "workspace-automation" "- melva
- engineering
- operations
- intelligence
- systembuilder"

write_agent "systembuilder" "System Builder" "Foundational platform and system scaffolding" "automation" "workspace-systembuilder" "- engineering
- operations
- automation
- melva"

cp "$repo_root/melva/agents/registry.yaml" "$agent_root/registry.yaml"

cat > "$agent_root/NETWORK.md" <<'EOF'
# MELVA Agent Network

Agents are persistent first-class entities.

Communication is explicit, not universal:

- MELVA coordinates the main functional leads.
- Team leads coordinate their own sub-agents.
- Cross-team specialist access is granted only where the handoff pattern requires it.
- If an agent needs information from a blocked path, it should escalate through an allowed contact instead of bypassing the network.
- In NemoClaw mode, all agents share the codex provider because only one API provider is active at a time.
EOF

echo "Seeded MELVA agents in $agent_root"
