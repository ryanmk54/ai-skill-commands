---
description: Add a Cursor chat reference to the companion chat log, not the task file
---

Follow **personal-kanban** `CHAT_LOG_GUIDE.md` (companion log first; task stays concise).

1. Resolve the target task and its `chat_log_path` (or create `chats/logs/<YYYY-MM-DD>-<slug>.md` under the board root and set `chat_log_path` on the task if missing).
2. Append or update a `### YYYY-MM-DD - <short title>` section in that companion log with:
   - `Chat:` markdown link `[title](transcript-id)`
   - `Workspace:` absolute path to the repo/worktree where the chat ran
   - `Transcript path:` absolute path to the `.jsonl` under `~/.cursor/projects/.../agent-transcripts/<id>/<id>.jsonl` if known
   - `Exported transcript:` path under `chats/exports/...` or `None`
   - `Outcome:` one factual sentence
   - `Follow-ups:` checkboxes for open items only
3. Update **Chat index** (`Total chats`, `Last updated`) in that log if present.
4. **Do not** add a “Related chats” bullet list under the task `## Notes` unless the user explicitly asked for it. At most ensure the task has `chat_log_path` and optionally one line pointing to the companion log.
5. List every file you changed at the end.
