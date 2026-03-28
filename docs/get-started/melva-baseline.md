# MELVA Baseline

This guide describes the portable MELVA baseline bundled in this repository.

## What It Includes

- `melva/workspace-base/`
  - `AGENTS.md`
  - `BOOTSTRAP.md`
  - `SOUL.md`
  - `TOOLS.md`
  - `IDENTITY.md`
  - `USER.md`
  - `HEARTBEAT.md`
- `melva/shared-skills/`
  - `agentmail`
  - `self-improvement`
  - `supermemory`
- `melva/config/`
  - `env.example`
  - `openclaw.example.json`

## Install From Repo Checkout

```bash
bash scripts/install-melva.sh
```

This installs missing user-level tools where possible, copies the MELVA workspace base, copies shared skills into `~/.openclaw/skills`, copies example config files, and runs verification.

## Curl-Friendly Goal

The intended future installer path is:

```bash
curl -fsSL <your-nemoclaw-url>/install-melva.sh | bash
```

For now, the repository checkout path is the supported internal baseline.

## After Install

Review:

- `~/.openclaw/env.example`
- `~/.openclaw/openclaw.example.json`

Then configure local credentials and MCP integration before starting a real onboarding run.

## Important Runtime Rules

- use `/sandbox/.openclaw` as the logical OpenClaw path root
- understand that these paths are backed by `/sandbox/.openclaw-data`
- respond to the user in Swedish
- keep technical docs and internal operating text in English
- treat agents as persistent first-class entities, not only temporary subagents
