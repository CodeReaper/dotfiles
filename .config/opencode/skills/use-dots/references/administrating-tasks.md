Include [reading-tasks.md](reading-tasks.md).

Include [exploring-tasks.md](exploring-tasks.md).

## dot add

Adds task.

Note that labels are part of the tasks markdown body as described in the task format file.

### Options

- `"title"`: Task title
- `-p N`: Priority 0-4 (0 = highest, default 2)
- `-d "text"`: Long description (markdown body)
- `-P ID`: Parent task ID (creates folder hierarchy)
- `-a ID`: Blocked by task ID (dependency)
- `--json`: Output created task as JSON

### Example

```
dot add "Implement API" -p 1 -a dots-1a2b3c4 -d "REST endpoints" --json
```

## dot on

Marks task(s) as `active`. Use when you begin working on tasks.

### Options

- `<id>`: Task ID

## dot off

Marks task(s) as `done` and archives them.

### Options

- `<id>`: Task ID
- `-r "reason"`: Close reason (optional)

## dot rm

Permanently deletes task file(s). If removing a parent, children are also deleted.

### Options

- `<id>`: Task ID

## dot purge

Permanently deletes all archived (completed) tasks.

## dot slugify

Renames all issue IDs (including archived) to include slugs based on their titles. Preserves the hex suffix and updates all dependency references.

This is useful if the configuration for naming of ids are changed.

## dot fix

Promotes orphaned children to root and removes missing parent folders.
