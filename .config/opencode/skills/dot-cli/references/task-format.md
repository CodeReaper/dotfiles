# Storage format

Tasks are stored as markdown files with YAML frontmatter in `.dots/`.

## Directory structure

```
.dots/
  a1b2c3d4e5f6a7b8.md              # Root dot (no children)
  f9e8d7c6b5a49382/                # Parent with children
    f9e8d7c6b5a49382.md            # Parent dot file
    1a2b3c4d5e6f7890.md            # Child dot
  archive/                          # Closed dots
    oldtask12345678.md             # Archived root dot
    oldparent1234567/              # Archived tree
      oldparent1234567.md
      oldchild23456789.md
  config                            # ID prefix setting
```

## File format

```yaml
---
title: Fix the bug
status: open
priority: 2
issue-type: task
created-at: 2024-12-24T10:30:00Z
blocks:
  - a3f2b1c8d9e04a7b
---
Description as markdown body here.
```

### Task body format

The description of a task is plain markdown format.

```
Cache responses based on status code. Lots of more
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
```

There should always be a regular markdown portion at the beginning - which is the entire task description.

There should always be a "Notes" section that contains key points from the description in list form.

The acceptance criteria, if present, are in their own section in list form.

The labels, if any labels are to be assigned to a task, are in their own section in list form where each item is composed by the formula `label:<label>`.

## ID format

IDs have the format `{prefix}-{slug}-{hex}`:

- `prefix`: Project prefix from `.dots/config` (default: `dots`)
- `slug`: URL-safe abbreviation of the title (max 32 chars)
- `hex`: 8-character random hex suffix

Example: `dots-fix-user-auth-a3f2b1c8`

Commands accept short prefixes: `dot on a3f2b1` matches `dots-fix-user-auth-a3f2b1c8`.

## Status flow

```
open -> active -> done (archived)
```

- `open`: Task created, not started
- `active`: Currently being worked on
- `done`: Completed, moved to archive

## Priority scale

- `0`: Critical
- `1`: High
- `2`: Normal (default)
- `3`: Low
- `4`: Backlog
