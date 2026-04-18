Include [reading-tasks.md](reading-tasks.md).

## dot ls

List tasks.

### Options

- `--status STATUS`: Filter by `open`, `active`, or `done` (default: open + active)
- `--json`: Output as JSON array

## dot ready

Lists tasks that are `open` and have no blocking dependencies (or blocker is `done`).

### Options

- `--json`: Output as JSON array

### Output format

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

## dot find

Case-insensitive search across title, description, close-reason, created-at, and closed-at.

### Options

- `"query"`: Search query

Shows open dots first, then archived.

### Special case for label-based search

When searching for tasks with a specific label like "example".

```
dot find "label: example"
```

### Output format

```
[1a2b3c4] o Design API        # o = open
[3c4d5e6] > Implement API   # > = active
[5e6f7a8] x Write tests    # x = done
```
