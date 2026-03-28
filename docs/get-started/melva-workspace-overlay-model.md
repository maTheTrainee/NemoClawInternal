# MELVA Workspace Overlay Model

MELVA workspaces are assembled in layers.

## Base Layer

The base layer comes from `melva/workspace-base/` and provides the shared OpenClaw operating core:

- `AGENTS.md`
- `SOUL.md`
- `TOOLS.md`
- `BOOTSTRAP.md`
- `IDENTITY.md`
- `USER.md`

This layer should stay stable unless a change is intended for every MELVA workspace.

## Agent Context Layer

Agent-specific context is added with:

- `scripts/apply-melva-agent-context.sh`

This creates `AGENT_CONTEXT.md` in each workspace.

## Workflow Layer

Operational behavior is added with:

- `scripts/apply-melva-agent-playbooks.sh`

This creates `WORKFLOW.md` in each workspace.

## Why This Model Exists

OpenClaw relies on continuity in the shared markdown files. Replacing the base files per agent would create drift and increase the chance of runtime confusion. The overlay model keeps the shared core intact while still giving each agent a clear role, mission, and handoff pattern.
