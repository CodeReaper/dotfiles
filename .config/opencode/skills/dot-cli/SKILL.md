---
name: dot-cli
description: Understand how to use the `dot` command to use dots for task management. Load skill to interact with tasks when dots handles task management as indicated by AGENTS.md or the presence of a .dots directory.
license: MIT
metadata:
  reference: https://github.com/joelreymont/dots
---

Dots is a minimal task tracker for AI coding agents — uses plain markdown files with YAML frontmatter. Supports parent-child relationships, priorities, and dependencies.

ALWAYS use the `dot` cli command, if possible.
AVOID reading the task files directly.
NEVER assume the format is understood when writing tasks, read [task-format.md](references/task-format.md) to understand the raw task file format and the task markdown body format.

## Reading tasks

Show task details, run:

```
# dot show <id>
dot show dots-1a2b3c4d5e6f7890
```

Example output:

```
ID:       dots-1a2b3c4d5e6f7890
Title:    Design API
Status:   open
Priority: 1
Desc:     Cache responses based on status code. Lots of more
description of implementation guidance here.

**Notes:**

- Cache 2xx and 3xx responses
- Do not cache 4xx, 5xx, 599+

**Acceptance Criteria:**

- 2xx/3xx responses cached
- 4xx/5xx/599+ not cached

**Labels:**

- label:F007
- label:cache
- label:phase1
Created: 2024-12-24T10:30:00Z
```

Note:

- "Desc" can be multi-lined.
- "Acceptance Criteria" subsection is optional.
- "Labels" subsection is optional and are likely irrelevant for implementation.

## Updating task state

Mark task as `done` by running:

```
dot off <id> [-r "reason"]
```

Options:

- `<id>`: Task ID
- `-r "reason"`: Close reason (optional)

## Exploring tasks

### List tasks

```
dot ls
```

Options:

- `--status STATUS`: Filter by `open`, `active`, or `done` (default: open + active)
- `--json`: Output as JSON array

... or list tasks that are `open` and have no blocking dependencies (or blocker is `done`) with:

```
dot ready
```

Options:

- `--json`: Output as JSON array

... or use free-text-search with:

```
dot find "query search terms"
```

... or search for labelled task with:

```
dot find "label: example"
```

The `dot find` command does not support `--json` output.

#### Json output format

```jsonc
[
  {
    "id": "dots-write-tests-5e6f7a8",
    "title": "Write tests",
    "description": "<markdown body>",
    "status": "open",
    "priority": 4,
    "issue_type": "task",
    "created_at": "\"2026-04-16T22:03:28.768655+02:00\"",
    "closed_at": null,
    "close_reason": null,
  },
]
```

#### Text output format

```
[1a2b3c4] o Design API     # o = open
[3c4d5e6] > Implement API  # > = active
[5e6f7a8] x Write tests    # x = done
```

## Administrative tasks

### Updating existing tasks

The `dot` cli tool cannot update a task, instead update the backing markdown file.

The task format reference file describes the contents of a task file. Adhere to its format.

### Adding tasks

```
dot add
```

Note that labels are part of the tasks markdown body as described in the task format file.

Options:

- `'title'`: Task title
- `-p N`: Priority 0-4 (0 = highest, default 2)
- `-d 'text'`: Long description (markdown body)
- `-P ID`: Parent task ID (creates folder hierarchy)
- `-a ID`: Blocked by task ID (dependency)
- `--json`: Output created task as JSON

Example:

```
dot add 'Implement API' -p 1 -a dots-1a2b3c4 -d 'REST endpoints' --json
```

### Removing tasks

```
dot rm <id>
```

Permanently deletes task. If removing a parent, children are also deleted.

```
dot purge
```

Permanently deletes all archived (completed) tasks.

## Misc

```
dot slugify
```

Renames all issue IDs (including archived) to include slugs based on their titles. Preserves the hex suffix and updates all dependency references.

This is useful if the configuration for naming of ids are changed.

```
dot fix
```

Promotes orphaned children to root and removes missing parent folders.
