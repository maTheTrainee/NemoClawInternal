# MELVA Config Blueprint

This file describes the configuration shape we want to be able to clone, install, and run later inside our NemoClaw git variant.

## Design Goal

The final system should support:

- clone repo
- run install/bootstrap
- provision baseline workspace files
- install approved skills
- register approved MCP integrations
- enable team-specific packs
- start MELVA with the correct runtime assumptions from the first session

## Config Layers

### 1. Source of Truth

This should be safe to store in git:

- startup prompts
- `BOOTSTRAP.md`
- `AGENTS.md`
- `SOUL.md`
- `TOOLS.md`
- baseline identity templates
- team pack definitions
- skill allowlist / manifest
- MCP config templates
- install and verify scripts

### 2. Runtime State

This changes during operation and should be treated separately:

- `USER.md`
- `MEMORY.md`
- `memory/YYYY-MM-DD.md`
- `.learnings/`
- local overrides
- machine-specific tool notes

### 3. Secrets

Never store these in workspace markdown:

- API keys
- tokens
- passwords
- secret refs resolved to plaintext

Use env vars, secret refs, or MCP/client auth instead.

## Baseline Capabilities

### Global Base

- ClawHub
- GitHub
- tmux
- Notion
- Context7
- mcporter
- AgentMail
- Supermemory MCP
- session-logs
- summarize

### Optional Global Add-ons

- AgentMail MCP
- Self-Improvement
- approved PDF parser
- video-frames
- nano-pdf
- himalaya
- gifgrep
- coding-agent

## Team Packs

### Coding Team Pack

- GitHub
- tmux
- Context7
- mcporter
- coding-agent
- session-logs

Purpose:

- work with repos
- monitor Claude Code/Codex terminal sessions
- inspect MCP integrations
- use current technical docs

### Sales Team Pack

- Notion
- AgentMail
- Supermemory MCP

Purpose:

- structure sales knowledge
- manage agent inboxes
- preserve reusable process knowledge

### Marketing Team Pack

- Notion
- AgentMail
- Supermemory MCP
- PDF parser
- gifgrep
- video-frames
- summarize

Purpose:

- content planning
- campaign material
- document-heavy research

### Research Team Pack

- Notion
- Context7
- Supermemory MCP
- PDF parser
- summarize
- session-logs

Purpose:

- knowledge ingestion
- PDF extraction
- technical and market research

## Runtime Rules That Must Be Present From Start

- use `/sandbox/.openclaw` as the logical path root
- understand that those paths persist through `/sandbox/.openclaw-data`
- write workspace files under `/sandbox/.openclaw/workspace`
- respond to the user in Swedish
- keep technical docs/internal instructions in English
- treat agents as persistent first-class entities, not only temporary subagents

## Backup Boundaries

### Safe for Git backup

- prompts
- bootstrap files
- team definitions
- skill manifests
- stable tool rules
- stable architecture docs

### Review before backup

- `USER.md`
- `MEMORY.md`
- daily memory files
- `.learnings/`
- team notes containing customer or operator details

### Never commit in plaintext

- secrets
- tokens
- passwords

## Future Install Shape

Later, this should likely become:

- `config/skills/`
- `config/mcp/`
- `config/teams/`
- `workspace/base/`
- `scripts/install.sh`
- `scripts/verify.sh`
- `scripts/export-backup.sh`

## Current Open Questions

- final approved PDF skill
- final approved self-improvement skill
- exact Notion integration method to standardize
- exact Supermemory MCP config format to standardize
- final AgentMail MCP config template
