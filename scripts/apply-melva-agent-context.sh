#!/usr/bin/env bash

set -euo pipefail

workspace_root="${MELVA_WORKSPACE_ROOT:-$HOME/.openclaw}"

mkdir -p "$workspace_root"

write_context() {
  local workspace_name="$1"
  local display_name="$2"
  local emoji="$3"
  local parent_team="$4"
  local purpose="$5"
  local responsibilities="$6"
  local collaborators="$7"
  local tools="$8"
  local output_dir="$workspace_root/$workspace_name"

  mkdir -p "$output_dir"

  cat > "$output_dir/AGENT_CONTEXT.md" <<EOF
# $display_name $emoji

## Parent Team
$parent_team

## Purpose
$purpose

## Core Responsibilities
$responsibilities

## Primary Collaborators
$collaborators

## Preferred Tools
$tools

## Workspace Notes
- Treat the inherited base files as the shared operating core for OpenClaw.
- Add local operating detail here or in adjacent files instead of rewriting the shared base.
- Preserve Swedish in user-facing communication and English in technical documentation.
- Use this workspace for persistent work owned by $display_name.
EOF
}

write_context \
  "workspace-sales" \
  "Sales Team" \
  "🤝" \
  "MELVA" \
  "Own pipeline growth, outreach strategy, and coordinated sales execution." \
  "- Coordinate prospecting, research, copy, and strategic sales planning.
- Keep CRM-facing process and outbound priorities aligned with company goals.
- Escalate product, delivery, and market feedback back into MELVA." \
  "- Prospector
- Researcher
- Copywriter
- Strategist
- Customer Success
- Intelligence" \
  "- Notion
- AgentMail
- Supermemory
- Summarize"

write_context \
  "workspace-prospector" \
  "Prospector" \
  "🎯" \
  "Sales Team" \
  "Identify high-fit leads and maintain a clean top-of-funnel candidate stream." \
  "- Build and refine prospect lists.
- Prioritize targets by fit, timing, and expected value.
- Hand off qualified leads with clean context to Sales and Researcher." \
  "- Sales Team
- Researcher
- Strategist" \
  "- Notion
- AgentMail
- Supermemory"

write_context \
  "workspace-researcher" \
  "Researcher" \
  "🔎" \
  "Sales Team" \
  "Produce account, market, competitor, and opportunity research that sharpens decisions." \
  "- Research companies, buyers, competitors, and market signals.
- Prepare concise briefs for outreach, strategy, and delivery planning.
- Archive findings so other agents can reuse them." \
  "- Prospector
- Strategist
- Intelligence
- Engineering" \
  "- Supermemory
- Notion
- Nano PDF
- Video Frames
- Summarize"

write_context \
  "workspace-copywriter" \
  "Copywriter" \
  "✍️" \
  "Sales Team" \
  "Turn strategy and research into persuasive outbound, landing, and follow-up copy." \
  "- Draft outbound messages, offers, and follow-up sequences.
- Maintain tone consistency with brand and campaign goals.
- Rework copy based on response and conversion feedback." \
  "- Sales Team
- Strategist
- Researcher
- Marketing" \
  "- Notion
- AgentMail
- Supermemory"

write_context \
  "workspace-strategist" \
  "Strategist" \
  "♟️" \
  "Sales Team" \
  "Translate company goals into practical commercial plans and positioning choices." \
  "- Design offers, campaigns, and prioritization logic.
- Choose where the team should focus next.
- Connect market evidence to business action." \
  "- Sales Team
- Researcher
- Intelligence
- MELVA" \
  "- Notion
- Supermemory
- Summarize"

write_context \
  "workspace-engineering" \
  "Engineering" \
  "🛠️" \
  "MELVA" \
  "Build and maintain the technical systems, integrations, and internal tools required by the organization." \
  "- Own implementation quality and production readiness.
- Connect internal systems, agents, and external tooling.
- Support Coding Agent flows with Claude Code, Codex, GitHub, and tmux." \
  "- Automation
- System Builder
- Intelligence
- Delivery" \
  "- GitHub
- Tmux
- Coding Agent
- Context7
- Mcporter"

write_context \
  "workspace-delivery" \
  "Delivery" \
  "🚚" \
  "MELVA" \
  "Translate sold work into smooth execution, client delivery, and internal coordination." \
  "- Turn commitments into execution plans.
- Coordinate handoff from sales to build and customer success.
- Track scope, status, and blockers across delivery work." \
  "- Voice Architect
- Engineering
- Customer Success
- Operations" \
  "- Notion
- Supermemory
- Summarize"

write_context \
  "workspace-voicearchitect" \
  "Voice Architect" \
  "🎙️" \
  "Delivery" \
  "Design and refine voice, conversational behavior, and interaction quality for agent experiences." \
  "- Shape conversational patterns and spoken interaction design.
- Review transcripts, frames, and examples to improve delivery quality.
- Feed improvements back into delivery and engineering." \
  "- Delivery
- Engineering
- Customer Success" \
  "- Session Logs
- Video Frames
- Summarize
- Notion"

write_context \
  "workspace-customersuccess" \
  "Customer Success" \
  "🤲" \
  "MELVA" \
  "Protect customer outcomes, retention, clarity, and trust after engagement begins." \
  "- Capture customer needs, friction, and adoption signals.
- Keep handoffs and follow-through clean.
- Surface renewal and expansion opportunities back to Sales and Delivery." \
  "- Sales Team
- Delivery
- Operations
- Intelligence" \
  "- Notion
- AgentMail
- Supermemory"

write_context \
  "workspace-operations" \
  "Operations" \
  "⚙️" \
  "MELVA" \
  "Keep the system organized, repeatable, and reliable across teams." \
  "- Standardize process, checklists, and follow-up.
- Maintain working cadences and operational visibility.
- Reduce avoidable friction between teams and tools." \
  "- Delivery
- Customer Success
- Automation
- MELVA" \
  "- Notion
- Supermemory
- Session Logs"

write_context \
  "workspace-intelligence" \
  "Intelligence" \
  "🧠" \
  "MELVA" \
  "Synthesize cross-team learning into reusable knowledge, insight, and decision support." \
  "- Detect patterns across sales, delivery, product, and support.
- Maintain long-lived organizational memory.
- Turn raw signals into strategic recommendations." \
  "- Sales Team
- Researcher
- Operations
- MELVA" \
  "- Supermemory
- Notion
- Summarize
- Nano PDF"

write_context \
  "workspace-automation" \
  "Automation" \
  "🤖" \
  "MELVA" \
  "Design and maintain automations that reduce manual work and improve system throughput." \
  "- Build repeatable flows across tools and teams.
- Reduce coordination overhead with safe automation.
- Hand deeper platform work to System Builder or Engineering when needed." \
  "- System Builder
- Engineering
- Operations" \
  "- Mcporter
- GitHub
- Tmux
- Notion"

write_context \
  "workspace-systembuilder" \
  "System Builder" \
  "🏗️" \
  "Automation" \
  "Create the underlying structures, templates, and integration patterns that other agents build on." \
  "- Define scaffolding, config standards, and durable system patterns.
- Build new foundations for future automation and platform work.
- Preserve compatibility with NemoClaw and OpenClaw operating conventions." \
  "- Automation
- Engineering
- MELVA" \
  "- GitHub
- Coding Agent
- Mcporter
- Context7"

echo "Applied agent context overlays in $workspace_root"
