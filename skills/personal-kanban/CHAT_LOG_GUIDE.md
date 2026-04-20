# Chat Log Format

Companion chat logs live under `chats/logs/` relative to the **board root** (the directory that contains `tasks/`, e.g. `/path/to/personal-kanban`).

Task Markdown files should stay concise and point to the companion chat log via frontmatter `chat_log_path`, unless the user explicitly asks for inline chat bullets in the task.

## When to update the chat log

When adding or updating Cursor chat references for a task:

1. **Update the companion chat log file first** (`chats/logs/<YYYY-MM-DD>-<slug>.md` or the path in `chat_log_path`).
2. Do **not** add a “Related chats” list under the task `## Notes` by default; keep only a pointer to the companion log unless the user asks otherwise.

## Goals

- Keep task notes lightweight.
- Keep chat details in one place.
- Make cross-workspace transcripts easy to reopen (store workspace + transcript file path; chat ID links alone can fail across projects).

## Recommended structure

```markdown
# <Task title>

## Related task
- Task ID: `<task_id>`
- Filename: `<task-file-name>.md`
- Last known path: `<absolute-task-path>`

## Repositories
- Primary: `<primary-worktree>`
- Secondary: `<optional-worktree>`

## Chat index
- Total chats: <count>
- Last updated: YYYY-MM-DD

## Chats

### YYYY-MM-DD - <short chat title>
- Chat: [<title>](<transcript-id>)
- Workspace: `<workspace-path>`
- Transcript path: `<absolute-path-to-jsonl>`
- Exported transcript: `<absolute-path-or-None>`
- Outcome: <1 sentence>
- Follow-ups:
  - [ ] <next step>

## Cross-chat decisions
- <decision 1>
- <decision 2>

## Exported chats
- `<absolute-export-path>` or `None yet.`

## Key decisions
- <optional concise summary bullets>
```

## Field guidance

- `Chat` link text should be human-readable; link target should be transcript ID.
- `Workspace` should be the repo/worktree where the chat happened.
- `Transcript path` should point to the `.jsonl` transcript file for reliable access (typically under `~/.cursor/projects/<slug>/agent-transcripts/<id>/<id>.jsonl`).
- `Exported transcript` should point to `chats/exports/YYYY-MM-month-name/...` when available.
- `Outcome` should be a factual one-line result.
- `Follow-ups` should include only open items.

## Task file convention

In task files, prefer this style:

- `Related chats are tracked in the companion log: <chat_log_path>.`

Only include individual chat bullets in task files when they are immediately relevant and temporary, or when the user explicitly requests them.
