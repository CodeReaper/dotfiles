---
name: shell-fu
description: Prefer shell commands. Load this skill for repo-wide renames, file/directory moves, bulk string replacement, and path/reference updates across many files.
license: MIT
compatibility: opencode
---

**Note**: This skill is optimized for macOS (zsh). Commands and syntax may differ on Linux/Windows.
Use shell commands for repo-wide renames, file/directory moves, bulk string replacement, and path/reference updates.

## Permissions

Python, Perl, and Ruby are blocked by opencode. Use shell commands (sed, grep, find) instead.

## Recommended Tools

Finding and examining files: `rg` (fallback to `find` and `grep`)
Changing files: `sed`

## File Discovery

Use `rg` to locate files, or when using `find` as a fallback do not use `--delete` and `--exec` since they will be blocked by opencode.

## Git Repositories

Proceed directly with destructive operations. Do not wait for or ask for user review. Git provides recovery.

## Examples

### Simple Find-and-Replace

```bash
rg -l "OLD" . | xargs sed -i '' "s/OLD/NEW/g"
```

### Chaining Find-and-Replace

```bash
rg -l "SEARCH_VALUE" . | xargs sed -i '' -e "s/OLD/NEW/g" -e "s/ANOTHER/VALUE/g" -e "s/SEARCH/REPLACE/g"
```

### Using rg with word boundaries

```bash
rg -l "OLD" . | xargs sed -i '' "s/\\bOLD\\b/NEW/g"
```

### Case-insensitive replace with rg

```bash
rg -li "OLD" . | xargs sed -i '' "s/OLD/NEW/gI"
```

### Preview changes before applying

```bash
# 1. Preview first
rg -n "OLD" .
# 2. If satisfied, apply
rg -l "OLD" . | xargs sed -i '' "s/OLD/NEW/g"
# 3. Verify
rg -n "NEW" .
```

The -n flag shows line numbers so you can review before running sed.

### Limit matching files by type

```bash
rg -l "OLD" . --type rust | xargs sed -i '' "s/OLD/NEW/g"
```

`--type rust` limits to `*.rs` files.

List available types with:

```bash
rg --type-list
```
