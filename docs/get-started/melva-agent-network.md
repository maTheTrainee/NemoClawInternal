# MELVA Agent Network

The MELVA setup includes a persistent agent layer in addition to the workspace layer.

Files:

- `melva/agents/registry.yaml`
- `scripts/setup-melva-agents.sh`

The runtime output is created under `~/.openclaw/agents/`:

- one folder per agent
- `AGENT_CARD.md`
- `CONTACTS.md`
- shared `registry.yaml`
- shared `NETWORK.md`

## Communication Model

Agent communication is intentionally scoped.

- `MELVA` talks to the functional leads.
- `Sales Team` coordinates the sales sub-agents.
- `Delivery` coordinates `Voice Architect`.
- `Automation` coordinates `System Builder`.
- Cross-team paths exist only where the work requires them.

## Provider Rule

In NemoClaw mode, only one API provider is active at a time. This setup is pinned to `codex`, so agent definitions and runtime notes assume a shared Codex provider rather than mixed provider routing.
