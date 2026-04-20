---
description: Find a chat transcript by ID and open or report path (use Codex 5.3)
---

Use the **gpt-5.3-codex** model for this request when available.

The user gives a Cursor chat / transcript UUID (or pasted link). Goal: make the transcript **locatable and openable** even when markdown `(uuid)` links fail across workspaces.

1. Search for `**/agent-transcripts/**/<uuid>.jsonl` under `~/.cursor/projects/` (or the user’s Cursor data directory). If multiple matches, list each with its project slug and pick the one that matches the stated workspace or repo if given.
2. Report clearly:
   - **Transcript file:** absolute path to the `.jsonl`
   - **Workspace hint:** infer from folder name (e.g. `home-ryan-src-foo`) or ask the user which worktree this chat belonged to.
3. **Open:** tell the user to open that file in the editor, or run a Cursor “Open File” on that path. Do not claim a special “open chat by ID” URL unless you know it works in their setup.
4. If no file is found: say so and suggest exporting the chat from Cursor into `chats/exports/YYYY-MM-month-name/<uuid>.md` per personal-kanban conventions.

Keep the reply short: paths and next action first.
