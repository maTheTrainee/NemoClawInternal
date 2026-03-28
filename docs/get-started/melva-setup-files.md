# MELVA Setup Files

This folder collects the MELVA-specific setup artifacts added in this repository.

## Main Locations

### Repo assets

- `melva/workspace-base/`
- `melva/shared-skills/`
- `melva/config/`

### Scripts

- `scripts/install-melva.sh`
- `scripts/verify-melva.sh`

### Supporting docs

- `docs/get-started/melva-baseline.md`

## Why This Exists

The goal is to keep MELVA reproducible:

- same workspace base
- same shared skills
- same install behavior
- same config templates

That way the custom NemoClaw distribution can fetch and stand up MELVA without rebuilding the setup manually.
