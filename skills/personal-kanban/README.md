# personal-kanban-skill

Versioned source for a Cursor skill that manages a file-backed Kanban board backed by Markdown files in status folders.

## Contents

- `SKILL.md`: the skill definition loaded by Cursor
- `CHANGELOG.md`: release notes for skill changes
- `LOCAL_CONFIG.example.md`: sample local configuration for the board root
- `scripts/install.sh`: installs the skill symlink and bootstraps local config

## Release approach

- Use semantic versioning
- Tag releases as `vMAJOR.MINOR.PATCH`
- Bump `MAJOR` for breaking workflow changes
- Bump `MINOR` for backward-compatible capabilities
- Bump `PATCH` for wording, examples, or clarification updates

## Deployment

Use the installer script:

`./scripts/install.sh`

The script creates:

- `~/.cursor/skills/personal-kanban` as a symlink to this repository
- `LOCAL_CONFIG.md` from the example file if it does not already exist
