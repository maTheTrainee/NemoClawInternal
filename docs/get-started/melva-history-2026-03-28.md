# MELVA History 2026-03-28

This note summarizes the MELVA baseline work brought into `NemoClawInternal`.

## Added

- MELVA workspace base files under `melva/workspace-base/`
- shared skills under `melva/shared-skills/`
- example config under `melva/config/`
- install script: `scripts/install-melva.sh`
- verify script: `scripts/verify-melva.sh`
- docs for future onboarding and reproduction

## Decisions

- AgentMail is part of the global baseline
- Supermemory is treated as real persistent memory via MCP, not "just RAG"
- skills and config should be git-tracked, secrets should not
- onboarding should not be the only place where keys are configured
- repo templates + env/SecretRef are preferred over plaintext secrets
