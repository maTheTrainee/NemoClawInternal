---
name: supermemory
description: Use Supermemory as persistent cross-session memory and archive via MCP. Prefer this when storing or recalling durable knowledge that should outlive a single chat session.
---

# Supermemory

Supermemory is the persistent memory/archive layer for this environment.

Treat it as real long-term memory infrastructure shared across sessions and tools.
Do not reduce it to "just RAG".

## Use When

- storing facts, preferences, project context, and durable notes
- retrieving prior context that should survive chat/session resets
- preserving reusable knowledge for MELVA and team agents
- creating a shared memory/archive layer across tools

## Operating Rule

- prefer the configured Supermemory MCP server for actual storage and recall
- use workspace markdown files for local operating rules and current workspace state
- use Supermemory for durable cross-session memory and archive

## Current Setup Intent

For the current environment, the preferred path is:

1. Supermemory via MCP
2. Local workspace files for active operating context
3. Promotion of stable knowledge between the two when useful

## Free-Tier Workaround

For the current setup, keep it simple:

- use the MCP server directly instead of building extra paid tooling around it
- avoid depending on paid-only API patterns unless they become necessary later
- if there is a feature gap, keep using workspace memory files locally and use Supermemory MCP for the durable subset

## Notes

- user-facing replies stay in Swedish
- technical memory structure and config can remain in English
- memory quality matters more than memory volume
