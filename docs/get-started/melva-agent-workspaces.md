# MELVA Agent Workspaces

The shared base workspace files are the OpenClaw operating core. They should stay stable and be extended additively.

To keep that behavior intact, each team workspace receives an `AGENT_CONTEXT.md` file instead of rewriting the shared base documents. This adds workspace-specific purpose, responsibilities, collaborators, and preferred tools while preserving the common runtime context.

The overlay script is:

- `scripts/apply-melva-agent-context.sh`

The current workspace set is:

- `workspace-sales`
- `workspace-prospector`
- `workspace-researcher`
- `workspace-copywriter`
- `workspace-strategist`
- `workspace-engineering`
- `workspace-delivery`
- `workspace-voicearchitect`
- `workspace-customersuccess`
- `workspace-operations`
- `workspace-intelligence`
- `workspace-automation`
- `workspace-systembuilder`

Recommended rule:

- Treat `AGENTS.md`, `SOUL.md`, `TOOLS.md`, `BOOTSTRAP.md`, and other base files as shared operating core.
- Put agent-specific operating detail in `AGENT_CONTEXT.md` or adjacent local files.
- Only modify shared base files when the change is intended to affect every MELVA workspace.
