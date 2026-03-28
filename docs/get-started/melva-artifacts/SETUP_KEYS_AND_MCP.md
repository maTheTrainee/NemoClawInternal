# Setup Keys And MCP

This file describes what still needs to be configured locally after cloning this repo.

## Required For Full Use

### Notion

- `NOTION_API_KEY`

### AgentMail

- `AGENTMAIL_API_KEY`
  or
- AgentMail MCP client configuration

### Supermemory

- MCP client configuration
- preferred endpoint currently:
  - `https://mcp.supermemory.ai/mcp`

## Optional But Useful

### nano-pdf

- `GEMINI_API_KEY`

### summarize

At least one of:

- `GEMINI_API_KEY`
- `OPENAI_API_KEY`
- `ANTHROPIC_API_KEY`

Optional helpers:

- `FIRECRAWL_API_KEY`
- `APIFY_API_TOKEN`

## Recommended Setup Strategy

Do not store plaintext secrets in git-tracked files.

Prefer:

1. env vars
2. SecretRef objects in local config
3. local untracked config files

## Important OpenClaw Behavior

- `skills.entries.<skill>.env` and `skills.entries.<skill>.apiKey` are injected per agent run
- they are not global shell exports
- SecretRefs are resolved into the active runtime snapshot
- unresolved active SecretRefs can block startup/reload

That means the safest repo pattern is:

- tracked example config
- local untracked real config
- optional onboarding/configure step for secrets after clone
