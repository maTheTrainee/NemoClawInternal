# MELVA Skill Install Status

Date: 2026-03-28

## Installed / Ready

### Bundled skills now eligible because dependencies are present

- `clawhub`
- `github`
- `tmux`
- `mcporter`
- `session-logs`
- `video-frames`
- `summarize`
- `nano-pdf`
- `himalaya`
- `gifgrep`
- `coding-agent`

### Bundled skills present but still need credentials/config

- `notion` - needs `NOTION_API_KEY`

### Shared external skills installed in `~/.openclaw/skills`

- `agentmail`
- `self-improvement`

### Shared local wrapper skills installed in `~/.openclaw/skills`

- `supermemory`

## Environment Notes

- `coding-agent` is usable because `claude` and `codex` are present
- `github` is usable because `gh` is present
- `session-logs` is usable because `jq` and `rg` are present
- `video-frames` is usable because `ffmpeg` is present
- `summarize` is installed via npm
- `nano-pdf` is installed via `uv tool install`
- `himalaya` is installed via user-level installer into `~/.local/bin`
- `gifgrep` is installed via local Go toolchain into `~/.local/bin`

## Still Needed Before Full Use

- Notion API key/config
- Supermemory MCP client configuration
- AgentMail API key or AgentMail MCP configuration
- optional `GEMINI_API_KEY` for `nano-pdf`
- optional model/provider keys for `summarize`

## Next Recommended Step

Configure MCP and credential templates:

- Supermemory MCP
- AgentMail MCP
- Notion API key handling
- optional summarize/nano-pdf provider envs
