---
name: personal-kanban
description: Manage a file-backed Kanban board stored as Markdown files in status folders such as todo, in-progress, review, done, and archive. Supports optional companion chat logs and exported chat transcripts alongside the board. Use when the user asks to create, list, move, summarize, review, complete, archive, reopen, or organize tasks and related chats.
---

# Personal Kanban

Version: 1.2.2

## Purpose

Use this skill to manage personal tasks stored as Markdown files on disk.

## Configuration

If `LOCAL_CONFIG.md` exists next to this skill, read it before operating on the board.

Use the configured board root and any configured status folders.

If no local config is present, ask the user for the board root before creating, moving, or summarizing tasks.

The board root is the directory that contains the status folders. If the user keeps a larger personal-kanban repository with sibling support folders, treat the `tasks/` directory as the board root and keep non-task material outside it.

Default status folders:

- `todo`
- `in-progress`
- `review`
- `done`
- `archive`

The folder is the source of truth for task status.

## Task model

- One task = one Markdown file.
- Store each task in exactly one status folder.
- Do not duplicate the status in frontmatter unless the user explicitly asks for it.
- Preserve task history inside the file instead of creating duplicate task files.
- Optional frontmatter is allowed when it adds durable context that will help resume the task later.
- Keep task files lightweight; put large supporting context in companion files.
- Use two keys for task identity: `date_created` (for example `YYYY-MM-DD`) and a short `task_id` slug.
- When creating a new task, set `date_created` and `task_id` so `date_created-task_id` matches the initial filename stem (for example `YYYY-MM-DD-short-task-title`).
- When long-lived references matter, prefer a stable `task_id` in frontmatter so related notes can survive status moves and filename renames.

Preferred filename format:

`YYYY-MM-DD-short-task-title.md`

Example:

`2026-04-15-add-kanban-skill.md`

Useful optional frontmatter keys:

- `task_id`
- `external_issue_system`
- `external_issue_id`
- `external_issue_url`
- `worktree_path`
- `chat_log_path`

## Companion chat tracking

When the user wants to track Cursor chats for a task, keep chat material outside the task status folders.

Recommended layout:

```text
/path/to/personal-kanban/
  tasks/
    todo/
    in-progress/
    review/
    done/
    archive/
  chats/
    logs/
    exports/
      YYYY-MM-month-name/
```

Guidelines:

- Treat `tasks/` as the Kanban board root.
- Treat `chats/` as a sibling support area, not part of task status.
- Use one chat log Markdown file per task or workstream.
- A chat log may reference multiple chats for the same task.
- Keep exported chat transcripts under `chats/exports/YYYY-MM-month-name/`.
- Prefer stable transcript IDs for export filenames.
- Keep only a pointer such as `chat_log_path` in the task file unless the user explicitly wants more detail in the task itself.

Suggested export folder format:

- `2026-04-april`
- `2026-05-may`

## Default task template

Use this template when creating a new task unless the user asks for a different format:

```markdown
---
title: Task title
date_created: 2026-04-15
task_id: task-title
external_issue_system: Jira
external_issue_id: ISSUE-123
external_issue_url: https://tracker.example.com/browse/ISSUE-123
worktree_path: /path/to/checkout
chat_log_path: /path/to/personal-kanban/chats/logs/2026-04-15-task-title.md
---

# Task title

## Summary
Short description of the task.

## Notes
- Context
- Constraints

## Checklist
- [ ] First step
- [ ] Second step

## History
- 2026-04-15: Task created in `todo`.
```

Omit frontmatter fields that are unknown or not useful for the task. When the user provides source-specific metadata such as `jira_issue_id`, convert it to generic fields like `external_issue_system: Jira` and `external_issue_id: NP-1234` instead of storing both forms unless the user explicitly asks to keep the source-specific key.

If the user wants chat tracking, use a companion chat log like this:

```markdown
# Task title

## Related task
- Task ID: `task-title`
- Filename: `2026-04-15-task-title.md`
- Last known path: `/path/to/personal-kanban/tasks/in-progress/2026-04-15-task-title.md`

## Repositories
- /path/to/checkout

## Chats
- 2026-04-15: [Initial debugging](transcript-id)
- 2026-04-16: [Follow-up implementation](transcript-id)

## Exported chats
- /path/to/personal-kanban/chats/exports/2026-04-april/transcript-id.md

## Key decisions
- Decision or summary note
```

## Core workflow

### Create a task

1. Choose the destination folder.
2. Use `todo` by default unless the user specifies a different starting state.
3. Create a Markdown file with a clear, readable filename.
4. Add enough context that the task can be resumed later.
5. Add optional frontmatter when durable metadata will help resume the task later.
6. When a task may be referenced from chat logs, companion notes, or external systems, set:
   - `date_created` to the task creation date (for example `YYYY-MM-DD`)
   - `task_id` to a short stable slug
   so that `date_created-task_id` matches the initial filename stem. Keep both fields unchanged across status moves and any future renames.
7. Prefer generic metadata keys such as `task_id`, `external_issue_system`, `external_issue_id`, `external_issue_url`, `worktree_path`, and `chat_log_path`.
8. If the user wants chat tracking, create or reference one companion chat log file rather than pasting long chat content into the task.
9. If the user provides source-specific issue metadata, translate it into the generic issue fields unless the user explicitly asks to preserve the original source-specific keys.
10. Add a `History` entry noting the creation date and initial status.

### Move a task

1. Confirm the target status is one of the valid folders.
2. Move the existing file instead of copying it.
3. Keep the same filename unless the user asks to rename it.
4. Append a `History` entry noting the status transition.

Do not move companion chat logs or exported chats when the task status changes.
If the task has a `task_id`, preserve it unchanged.

### Review or summarize the board

1. Read the board folders.
2. Group tasks by status.
3. Give a concise summary with blocked items or missing context called out.
4. Highlight empty columns only if useful.

Ignore sibling folders such as `chats/` unless the user explicitly asks for chat-related information.

### Complete a task

1. Move the file to `done`.
2. Add a `History` entry noting completion.
3. Leave unfinished checklist items intact unless the user asks to rewrite them.

### Archive a task

1. Move the file to `archive`.
2. Preserve the file contents.
3. Add a `History` entry explaining why it was archived when that context is known.

## Guardrails

- Never invent new status folders unless the user explicitly changes the workflow.
- If a requested status is ambiguous, ask for clarification.
- Prefer editing the existing task file over creating a replacement.
- Keep task files human-readable and lightweight.
- Use frontmatter sparingly and only for metadata that is likely to matter when resuming the task.
- Preserve user-written notes and checklist items.
- If multiple tasks could match a request, ask which one to use.
- Do not treat companion folders such as `chats/` as task status folders.
- Do not paste large chat transcripts into task files unless the user explicitly requests that format.
- Prefer one chat log per task with references to multiple chats over one task file per chat.
- Prefer `task_id` rather than full task paths as the stable identity in companion chat logs.

## Request patterns

Apply this skill for requests like:

- "Create a new task in my Kanban board"
- "Move this task to review"
- "What is currently in progress?"
- "Archive completed tasks"
- "Summarize my board"
- "Create a Markdown task file for this work"
- "Track the chats related to this task"
- "Add a companion chat log for this task"
- "Save exported chat output without cluttering the task file"

## Notes for the agent

- Read `LOCAL_CONFIG.md` first when it exists.
- Ask for the board root if local configuration is missing.
- Treat the directory layout as stable unless the user changes it.
- Favor concise task files over elaborate project-management metadata.
- `worktree_path` can be important context in multi-repo or multi-worktree setups, so include it in frontmatter when the user asks or when it is clearly relevant.
- If the board lives under `/path/to/personal-kanban/tasks`, keep chat logs and exports in sibling `/path/to/personal-kanban/chats` folders, not inside the status folders.
