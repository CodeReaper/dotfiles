---
name: git-staging-checkpoints
description: Use when the working directory is a Git repository; load prior to running any git commands.
user-invocable: false
---

# Git Staging Checkpoints

Staging is the intentional way of the user to save checkpoints while work is in progress. Staged changes may mark any point in the work, such as a handoff, a compiling state, or an incomplete change whose tests do not pass yet.

- Treat staged and unstaged changes together as the working changes.
- Do not mention staged changes as a concern, and do not investigate why changes are staged.

# Git Restrictions

Unless very explicitly told by the user:

- Do NOT run `git add`.
- Do NOT change the index to make a diff easier to inspect.
- Do NOT run `git commit`.

## Reviewing the complete working changes

Use `git diff HEAD` to review tracked changes relative to `HEAD`. It includes both staged and unstaged modifications, so it is the appropriate combined view; `git diff` alone omits staged changes, and `git diff --cached` omits unstaged changes.

`git diff HEAD` does not include untracked files. Identify them with `git status --short` and inspect their contents directly. Do not stage them to include them in a diff.
