#!/usr/bin/env bash

set -euo pipefail

workspace_root="${MELVA_WORKSPACE_ROOT:-$HOME/.openclaw}"

mkdir -p "$workspace_root"

write_playbook() {
  local workspace_name="$1"
  local output_dir="$workspace_root/$workspace_name"
  local mission="$2"
  local inputs="$3"
  local outputs="$4"
  local decisions="$5"
  local handoffs="$6"

  mkdir -p "$output_dir"

  cat > "$output_dir/WORKFLOW.md" <<EOF
# Workflow

## Mission
$mission

## Inputs
$inputs

## Outputs
$outputs

## Decision Rules
$decisions

## Handoff Pattern
$handoffs
EOF
}

write_playbook \
  "workspace-sales" \
  "Drive coordinated revenue motion from targeting through conversion and expansion." \
  "- Qualified lead lists
- Research briefs
- Offer strategy
- Customer feedback and market signals" \
  "- Outreach priorities
- Campaign direction
- Commercial handoff packages
- Escalations to MELVA" \
  "- Favor qualified pipeline over raw activity volume.
- Keep positioning consistent across the team.
- Escalate gaps in product, delivery, or messaging quickly." \
  "- Receive inputs from Prospector, Researcher, Copywriter, and Strategist.
- Pass converted work to Delivery and Customer Success.
- Feed patterns back into Intelligence."

write_playbook \
  "workspace-prospector" \
  "Build a steady stream of high-fit accounts and contacts." \
  "- ICP definitions
- Sales priorities
- Existing CRM or list data" \
  "- Prioritized prospect lists
- Clean account/contact notes
- Qualification snapshots" \
  "- Prefer fit, timing, and reachable contacts over list size.
- Avoid noisy or weak-fit prospects.
- Keep rationale explicit so downstream agents can trust the handoff." \
  "- Hand off researched prospects to Sales Team and Researcher."

write_playbook \
  "workspace-researcher" \
  "Turn fragmented account and market information into reusable decision support." \
  "- Prospect targets
- Market questions
- Competitor prompts
- Customer or product context" \
  "- Account briefs
- Market summaries
- Competitor comparisons
- Archived findings" \
  "- Prefer concise evidence-rich output.
- Save reusable knowledge into durable memory.
- Distinguish between facts, inferences, and open questions." \
  "- Hand off briefs to Sales Team, Strategist, Intelligence, and Engineering when technical context matters."

write_playbook \
  "workspace-copywriter" \
  "Create persuasive, context-aware messaging that improves response and conversion." \
  "- Research briefs
- Offer strategy
- Brand voice guidance
- Campaign goals" \
  "- Outbound sequences
- Offer copy
- Landing page concepts
- Follow-up drafts" \
  "- Match tone to the prospect and channel.
- Keep copy measurable and easy to iterate.
- Use research and strategy instead of generic persuasion." \
  "- Hand off drafts to Sales Team for execution and to Strategist for refinement."

write_playbook \
  "workspace-strategist" \
  "Choose the right commercial moves based on evidence, leverage, and timing." \
  "- Company priorities
- Research output
- Sales performance data
- Delivery constraints" \
  "- Offer recommendations
- Prioritization frameworks
- Positioning choices
- Campaign plans" \
  "- Optimize for leverage, clarity, and fit.
- Avoid strategies that sales or delivery cannot sustain.
- Convert abstract goals into executable plans." \
  "- Hand off strategic plans to Sales Team, MELVA, and Delivery."

write_playbook \
  "workspace-engineering" \
  "Build reliable systems and integrations that let the organization execute at speed." \
  "- Product or automation requirements
- Technical debt or bug reports
- Team requests for tooling
- Integration needs" \
  "- Implemented systems
- Fixes and integrations
- Technical recommendations
- Deployment-ready changes" \
  "- Protect correctness and maintainability.
- Prefer reusable patterns over brittle one-offs.
- Keep agent workflows compatible with NemoClaw/OpenClaw conventions." \
  "- Hand off working systems to Delivery, Automation, and System Builder."

write_playbook \
  "workspace-delivery" \
  "Turn commitments into clean execution with minimal client-side friction." \
  "- Sold scope
- Technical inputs
- Customer expectations
- Internal timing constraints" \
  "- Delivery plans
- Status updates
- Internal handoff notes
- Blocker escalations" \
  "- Protect scope clarity and execution quality.
- Surface blockers before they turn into delivery risk.
- Keep customer-facing work aligned with what was promised." \
  "- Hand off execution details to Voice Architect, Engineering, Customer Success, and Operations."

write_playbook \
  "workspace-voicearchitect" \
  "Design the voice, flow, and interaction quality of conversational systems." \
  "- Delivery goals
- Transcript or session data
- Product behavior notes
- Customer feedback" \
  "- Voice system guidance
- Prompt or flow refinements
- Interaction recommendations
- Quality review notes" \
  "- Optimize for clarity, trust, and natural flow.
- Ground changes in observed sessions, not taste alone.
- Coordinate with Engineering when changes affect system behavior." \
  "- Hand off refinements to Delivery and Engineering."

write_playbook \
  "workspace-customersuccess" \
  "Maintain healthy customer outcomes and convert operational signals into retention insight." \
  "- Customer conversations
- Delivery status
- Support or friction notes
- Expansion opportunities" \
  "- Success summaries
- Retention risks
- Follow-up actions
- Expansion signals" \
  "- Optimize for clarity, trust, and outcomes.
- Close loops reliably.
- Escalate risk early to Delivery, Sales, or MELVA." \
  "- Hand off product and sentiment signals to Sales, Delivery, Operations, and Intelligence."

write_playbook \
  "workspace-operations" \
  "Create operational stability, repeatability, and visibility across the organization." \
  "- Team requests
- Process gaps
- Delivery and customer signals
- Internal coordination needs" \
  "- Process docs
- Checklists
- Cadence structures
- Operational status views" \
  "- Favor simple durable systems over elaborate workflows.
- Standardize where repetition creates drag.
- Keep the system legible to every team." \
  "- Hand off operational structures to every team, with special focus on Delivery, Customer Success, and Automation."

write_playbook \
  "workspace-intelligence" \
  "Turn distributed activity into durable memory, patterns, and decision advantage." \
  "- Sales data
- Research
- Delivery and support signals
- Operational patterns" \
  "- Synthesized insights
- Memory structures
- Strategic recommendations
- Early warning signals" \
  "- Separate observation from interpretation.
- Prefer reusable knowledge over one-off summaries.
- Connect signals across teams before escalating conclusions." \
  "- Hand off synthesized insight to MELVA, Sales Team, Operations, and Engineering."

write_playbook \
  "workspace-automation" \
  "Reduce manual work by building safe automations that fit how the teams actually operate." \
  "- Process pain points
- Tool integration needs
- Repetitive workflows
- Requests from Engineering or Operations" \
  "- Automated workflows
- Integration notes
- Trigger/action maps
- Maintenance recommendations" \
  "- Automate only when the flow is understood.
- Favor transparent, debuggable automations.
- Escalate deeper platform work to System Builder or Engineering." \
  "- Hand off implemented flows to Operations, Engineering, and System Builder."

write_playbook \
  "workspace-systembuilder" \
  "Create the scaffolding and patterns that make the broader agent system easier to evolve." \
  "- Platform requirements
- Architecture proposals
- Automation needs
- Engineering constraints" \
  "- System templates
- Config standards
- Architecture patterns
- Foundational integrations" \
  "- Optimize for reuse and long-term coherence.
- Preserve compatibility with existing OpenClaw runtime behavior.
- Build frameworks that other agents can adopt safely." \
  "- Hand off shared structures to Automation, Engineering, and MELVA."

echo "Applied workflow overlays in $workspace_root"
