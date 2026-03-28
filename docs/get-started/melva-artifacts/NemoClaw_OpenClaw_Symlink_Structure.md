# NemoClaw/OpenClaw Symlink Structure

Date verified: 2026-03-28

This note documents the verified OpenClaw path layout inside the running `nemoclaw` sandbox so it can be reused in future prompts, docs, and migrations.

## Verified Symlinks

Inside the sandbox, OpenClaw exposes logical paths under `/sandbox/.openclaw/`.
These are symlinks that point to the persistent backing store under `/sandbox/.openclaw-data/`.

- `/sandbox/.openclaw/agents` -> `/sandbox/.openclaw-data/agents`
- `/sandbox/.openclaw/extensions` -> `/sandbox/.openclaw-data/extensions`
- `/sandbox/.openclaw/workspace` -> `/sandbox/.openclaw-data/workspace`
- `/sandbox/.openclaw/skills` -> `/sandbox/.openclaw-data/skills`
- `/sandbox/.openclaw/hooks` -> `/sandbox/.openclaw-data/hooks`
- `/sandbox/.openclaw/identity` -> `/sandbox/.openclaw-data/identity`
- `/sandbox/.openclaw/devices` -> `/sandbox/.openclaw-data/devices`
- `/sandbox/.openclaw/canvas` -> `/sandbox/.openclaw-data/canvas`
- `/sandbox/.openclaw/cron` -> `/sandbox/.openclaw-data/cron`
- `/sandbox/.openclaw/update-check.json` -> `/sandbox/.openclaw-data/update-check.json`

## What This Means

- OpenClaw should normally use `/sandbox/.openclaw/...` as the logical interface.
- Persistence lives under `/sandbox/.openclaw-data/...`.
- The model should be told explicitly where it is expected to write, because it will not infer the intended writable layout automatically.
- If we do not tell it this early, it may try incorrect paths such as `/workspace`, `~/workspace`, or other guessed directories.

## Guidance For Future Agent Instructions

Use English for system/bootstrap instructions unless a Swedish phrase is specifically needed.

Recommended guidance:

```text
In NemoClaw sandboxes, use /sandbox/.openclaw as the logical OpenClaw path root.
These paths are symlinked to persistent storage under /sandbox/.openclaw-data.
Write project and user-facing workspace files under /sandbox/.openclaw/workspace.
Use the corresponding /sandbox/.openclaw/... paths for agents, skills, hooks, identity, devices, canvas, and cron state.
Do not assume /workspace, ~/, or arbitrary host paths are valid writable locations.
Respond to the user in Swedish, but keep technical documentation and internal instructions in English unless a specific Swedish phrase is required.
```

## Verification Notes

The symlink targets were verified directly in the running sandbox on 2026-03-28.
The backing paths under `/sandbox/.openclaw-data/` were also confirmed to exist.
