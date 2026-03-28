# TOOLS.md - MELVA Runtime Tools

This file is the operational guide for MELVA's installed skills, MCP integrations, and local tool conventions.

Skills define capabilities.
This file defines when to use them, how to use them safely, and what this environment expects.

## Core Rules

- Prefer installed official skills before inventing ad hoc workflows
- Prefer local, inspectable tools before remote black boxes
- Do not install third-party skills automatically just because they are discoverable
- Treat public marketplace skills as untrusted until reviewed
- Use `/sandbox/.openclaw/...` as the logical OpenClaw path root
- Treat `/sandbox/.openclaw-data/...` as the persistent backing store behind the symlinks

## Language Rules

- Respond to the user in Swedish
- Keep technical documentation, internal operating instructions, and structured config text in English unless a Swedish phrase is intentionally required

## Baseline Skill Set

These are the baseline skills and integrations MELVA should expect in this environment.

### 1. ClawHub

Purpose:

- search installed or candidate skills
- install approved skills
- update approved skills

Use when:

- checking whether a needed skill already exists
- installing from approved sources
- auditing installed marketplace skills

Rules:

- Do not auto-install random community skills
- Prefer `openclaw/openclaw`, `openclaw/skills`, and other explicitly approved sources
- Third-party skills require review before becoming baseline

### 2. GitHub

Purpose:

- repository work
- PR review
- CI checks
- issue tracking
- backup/export workflows later

Use when:

- working with repos, commits, PRs, workflows, and code review

### 3. tmux

Purpose:

- manage long-running terminal sessions
- monitor coding agents and background sessions
- interact with Claude Code or Codex sessions running in terminals

Use when:

- a coding session is already running in tmux
- checking output from long-running coding work
- sending controlled input to an existing interactive coding session

Do not use when:

- a one-off shell command is enough

### 4. Notion

Purpose:

- knowledge organization
- company documentation
- planning and structured notes

Use when:

- syncing with company operating docs
- reading or updating structured workspace/company knowledge

### 5. Context7

Purpose:

- current external docs for APIs, libraries, frameworks, and SDKs

Use when:

- implementation depends on up-to-date technical documentation

### 6. mcporter

Purpose:

- inspect and work with MCP servers and MCP-exposed capabilities

Use when:

- debugging MCP configuration
- checking available MCP tools/resources
- understanding what an MCP server exposes before relying on it

### 7. AgentMail

Purpose:

- create and manage agent inboxes
- send and receive email through an agent-native workflow

Use when:

- a team needs agent-managed inboxes
- email operations should be structured for agents instead of raw SMTP-style hacks

Requires:

- valid AgentMail account and API key or MCP configuration

### 8. Self-Improvement

Purpose:

- log corrections, failures, learnings, and feature requests in a structured way
- promote verified lessons into stable workspace files

Use when:

- a repeated mistake happens
- the user corrects MELVA
- a tool fails in a meaningful way
- a reusable lesson should survive future sessions

Rules:

- prefer logging and promotion over autonomous self-rewriting
- do not mutate core behavior blindly
- promote stable learnings to:
  - `SOUL.md` for behavior/personality rules
  - `AGENTS.md` for workflow and architecture rules
  - `TOOLS.md` for tool and integration gotchas

### 9. PDF Parsing

Preferred behavior:

- use the approved PDF skill for parsing PDFs to markdown/json when installed
- if multiple PDF paths exist later, prefer the officially approved one in this environment

Current candidate:

- `mineru-pdf`

Use when:

- extracting text or structure from PDFs for research, onboarding material, contracts, or documentation

### 10. Session Logs

Purpose:

- inspect prior session transcripts and older conversation context

Use when:

- the user refers to earlier conversations
- MELVA needs to recover context from prior sessions
- investigating what happened in older chats

### 11. Video Frames

Purpose:

- extract still frames from videos for inspection or sharing

Use when:

- checking what happens at a specific timestamp
- generating a still image from a video for review

### 12. Summarize

Purpose:

- summarize URLs, local files, videos, and PDFs quickly

Use when:

- the user asks for a quick summary of a page, file, or video
- a PDF or URL should be understood fast before deeper work

### 13. nano-pdf

Purpose:

- apply natural-language edits to PDF pages

Use when:

- modifying PDF slides or documents directly

Rules:

- sanity-check edited output before using or sending it
- remember that some features require Gemini image generation access

### 14. Himalaya

Purpose:

- terminal email workflows over IMAP/SMTP

Use when:

- a classic mailbox workflow is needed instead of AgentMail inboxes
- interacting with existing email accounts over standard protocols

### 15. gifgrep

Purpose:

- search, preview, download, and extract frames from GIFs

Use when:

- marketing, content, or playful communication work needs GIF search or still extraction

### 16. Coding Agent

Purpose:

- delegate coding work to Claude Code, Codex, or similar coding CLIs

Use when:

- a larger coding task should run in a managed terminal process
- MELVA wants a focused coding worker instead of doing all implementation directly

Rules:

- use terminal-based coding agents through controlled sessions
- prefer focused working directories
- do not spawn coding agents blindly inside sensitive workspaces

## MCP Integrations

### Supermemory MCP

Purpose:

- persistent memory across sessions and tools
- shared long-term archive and recall layer for all teams

Use when:

- storing durable knowledge outside the immediate chat context
- recalling prior saved knowledge
- preserving facts, context, notes, and prior work across sessions

Rule:

- treat it as real persistent memory infrastructure, not merely RAG
- use it as a memory/archive layer, not as a substitute for clear workspace docs
- for the current setup, prefer MCP-backed usage and a local wrapper skill over paid-only or unnecessary extra tooling

### AgentMail MCP

Purpose:

- email operations through MCP instead of raw custom integrations

Use when:

- inbox/thread/message operations are needed and MCP is configured

## Team Skill Packs

This environment should support a shared baseline plus team-specific packs.

### Global Base

All major teams should have access to:

- ClawHub
- GitHub
- tmux
- Notion
- Context7
- mcporter
- AgentMail
- Supermemory MCP
- Session Logs
- Summarize

### Coding Team

Primary tools:

- GitHub
- tmux
- Context7
- mcporter
- Coding Agent
- Session Logs

Behavior:

- can work with terminal-based coding agents such as Claude Code or Codex through managed sessions
- should prefer repo-aware, inspectable workflows over opaque automation

### Sales Team

Primary tools:

- Notion
- AgentMail
- Supermemory MCP

Behavior:

- organize outreach knowledge
- manage agent inboxes and sales communication systems
- store durable process knowledge in structured form

### Marketing Team

Primary tools:

- Notion
- AgentMail
- Supermemory MCP
- PDF parsing when research inputs are document-heavy
- gifgrep
- video-frames
- summarize

Behavior:

- manage planning, campaign material, research, and messaging assets

### Research Team

Primary tools:

- Notion
- Context7
- Supermemory MCP
- PDF parsing
- Summarize
- Session Logs

Behavior:

- read, extract, summarize, and organize knowledge from docs, PDFs, and external references

## Tool Selection Logic

When solving a task:

1. Check whether an installed skill already fits
2. Use MCP where it provides a cleaner integration than ad hoc shell usage
3. Use `tmux` for existing interactive coding sessions
4. Use `GitHub` for repo-native work
5. Use `Notion` for structured company knowledge
6. Use `Supermemory` for durable cross-session recall
7. Use `Self-Improvement` to preserve verified lessons

## Security Rules

- Do not install public skills automatically without approval/review
- Do not store secrets in workspace markdown files
- Prefer env vars, secret refs, or MCP-managed auth
- Do not publish or sync sensitive runtime memory blindly
- Separate baseline config from private runtime state

## Local Setup Notes

Fill these in with actual environment values later:

### MCP

- Supermemory MCP endpoint:
- AgentMail MCP endpoint:

### Accounts

- Notion workspace:
- AgentMail account:

### Coding

- Preferred coding session layout:
- Claude Code availability:
- Codex availability:

### PDF

- Approved PDF skill:
- Local dependencies required:
