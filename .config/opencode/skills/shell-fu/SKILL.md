---
name: shell-fu
description: Use proactively for repo-wide renames, file/directory moves, bulk string replacement, and path/reference updates across many files. Especially useful when a task involves renaming identifiers plus filesystem paths together. Prefer over ad hoc Python/Perl scripts on macOS.
license: MIT
compatibility: opencode
metadata:
  audience: all-developers
  workflow: text-processing
  platform: macos
---

**Note**: This skill is optimized for macOS (zsh). Commands and syntax may differ on Linux/Windows.

## File Discovery

Use `find` to locate files, but avoid `--delete` and `--exec`.

## The Scratch Pad Pattern

Use `/tmp` as temporary storage for building a **delimiter-separated table**, e.g. `path<tab>file<tab>replacement`.

1. Build the table using standard tools: grep, cut, sed, (awk as a fallback and only when other tools cannot accomplish the task)
2. Use tab (`\t`) or null-byte delimiters - avoid spaces/newlines in paths
3. Chain operations: discover -> extract -> transform -> apply

A scratch pad file is not required if the operation is simple enough. Pipe replacements directly into a while loop.

## Detect Git Repository

```bash
if git branch --show-current > /dev/null 2>&1; then
    # Git repository - proceed directly
else
    # Not a git repository - review /tmp table first
fi
```

## Git Repositories

Proceed directly with destructive operations. Do not wait for or ask for user review. Git provides recovery.

## Non-Git Repositories

Review the `/tmp` table before applying changes.

## Common Patterns

### Simple Find-and-Replace (No Scratch Pad)

```bash
grep -rl "OLD" . | while read -r file; do
    sed -i '' "s/OLD/NEW/g" "$file"
done
```

### Bulk File Rename

```bash
# Shell loop
for f in *.txt; do
    printf '%s\t%s\n' "$f" "${f%.txt}.md"
done > /tmp/renames.tsv

# Or find + while
find . -name "*.txt" | while read -r f; do
    printf '%s\t%s\n' "$f" "${f%.txt}.md"
done > /tmp/renames.tsv

while IFS=$'\t' read -r src dst; do
    mv "$src" "$dst"
done < /tmp/renames.tsv
```

### Multi-File Find-and-Replace

```bash
# Build: file<tab>src<tab>dst
grep -rl "OLD" . | sed 's/$/\tOLD\tNEW/' > /tmp/replacements.tsv

while IFS=$'\t' read -r file src dst; do
    sed -i '' "s/$src/$dst/g" "$file"
done < /tmp/replacements.tsv
```

### Rename Based on File Content

```bash
# Build: path<tab>src<tab>dst
for f in *.txt; do
    val=$(head -1 "$f")
    printf '%s\t%s\t%s\n' "$f" "$f" "${val}.txt"
done > /tmp/renames.tsv

while IFS=$'\t' read -r src dst; do
    mv "$src" "$dst"
done < /tmp/renames.tsv
```
