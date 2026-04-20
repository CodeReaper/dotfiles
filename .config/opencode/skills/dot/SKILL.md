---
name: dot
description: Read and close dot tasks with an id. Load skill to read tasks when tasks are managed by dots as indicated by AGENTS.md or the presence of a .dots directory.
license: MIT
metadata:
  reference: https://github.com/joelreymont/dots
---

Dots is a minimal task tracker for AI coding agents — uses plain markdown files with YAML frontmatter. Supports parent-child relationships, priorities, and dependencies.

ALWAYS use the `dot` cli command, if possible.
AVOID reading the task files directly.

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
