# Changelog

All notable changes to this skill will be documented in this file.

## [1.2.2] - 2026-04-16

### Changed

- Split task identity into `date_created` and `task_id` frontmatter keys; creation now requires these fields to combine to the initial filename stem

## [1.2.1] - 2026-04-16

### Added

- Companion chat tracking guidance for sibling `chats/` folders alongside the `tasks/` board root
- Recommended layout for `chats/logs/` and `chats/exports/YYYY-MM-month-name/`
- Companion chat log template with related task, repository, chat, export, and decision sections
- `task_id` guidance and examples for stable task references across status moves and filename renames
- `chat_log_path` as an optional frontmatter key for linking a task to its chat log
- Guardrails for keeping large chat transcripts out of task files and treating `chats/` as support material rather than task status

### Changed

- Expanded the skill description to include task-related chat organization
- Updated the default task template to show `task_id` and `chat_log_path`
- Updated the task creation and move workflows to preserve stable task identity and keep companion chat material outside status folders
- Expanded request patterns to include tracking chats, adding companion chat logs, and saving exported chat output

## [1.1.2] - 2026-04-16

### Added

- Optional frontmatter guidance for task files
- Example frontmatter showing `external_issue_system`, `external_issue_id`, `external_issue_url`, and `worktree_path`
- Guidance for translating source-specific issue metadata into generic external issue fields
- Recommendation to use `worktree_path` for repository or checkout context

### Changed

- Updated the task creation workflow to include optional frontmatter and generic metadata keys
- Clarified that frontmatter should stay lightweight and only include durable resume context

## [1.0.0] - 2026-04-15

### Added

- Initial `personal-kanban` skill
- File-backed Kanban workflow for `todo`, `in-progress`, `review`, `done`, and `archive`
- Basic versioning guidance in the repository
