---
name: shell-fu
description: Prefer shell commands. Use when performing repo-wide renames, file/directory moves, bulk string replacement, and path/reference updates across many files on macOS and Linux.
license: MIT
---

Use shell commands for repo-wide renames, file/directory moves, bulk string replacement, and path/reference updates.

## Recommended Tools

Use shell commands such as `rg`, `grep`, `find`, and `sed`.

Finding and examining files: `rg` (fallback to `find` and `grep`)
Changing file contents: `sed`

## File Discovery

Use `rg` to locate files, or `find` as a fallback. Avoid `find` options such as `-delete` and `-exec` that may be blocked by the environment.

Using `--hidden` on `rg` includes hidden files while still respecting ignore rules.

### Limit matching files by type

```bash
rg -l 'OLD' . --type rust
```

`--type rust` limits to `*.rs` files.

List available types with:

```bash
rg --type-list
```

## Git Repositories

Git provides recovery for tracked files. Before a bulk search-and-replace edit, check whether any target files are untracked. If untracked files would be changed, identify them and ask the user for confirmation before proceeding.

The workflow below compares matching files with Git's untracked files. The searches respect ignore rules, so ignored files are excluded from both lists.

## Cross-Platform Commands

The examples target common macOS and Linux environments. `sed` in-place editing differs between BSD `sed` (macOS) and GNU `sed` (common on Linux). Use the matching form for the current system:

```bash
# macOS / BSD sed
sed -i '' 's/OLD/NEW/g' file

# Linux / GNU sed
sed -i 's/OLD/NEW/g' file
```

For commands that pass filenames between tools, use NUL delimiters to handle spaces and other special characters in paths. `rg --null` and `xargs -0` are available in common macOS and Linux environments.

## Workflow for renaming and moving files and directories

Use `mv`.

## Workflow for updating strings

1. Determine the files the requested edit could change. Build the `rg` selection to include every file the edit could modify, accounting for every search term, case-sensitivity, and file-type filter. For a multi-pattern edit, include every pattern; for example, use multiple `-e` options. Ensure the `rg` patterns cover the edit command's matches, even if its regex syntax differs. The replacement text does not determine the target files.

```sh
{ rg --hidden -l -e 'SEARCH_PATTERN_1' -e 'SEARCH_PATTERN_2'; git ls-files --others --exclude-standard; } |
  sort |
  uniq -d
```

Replace the example patterns and add any relevant `rg` options, such as `-i` or `--type rust`, to match the requested edit. Any paths printed by `uniq -d` are untracked targets. Ask the user for confirmation before changing them. This line-based comparison is intended for ordinary filenames; filenames containing newlines or other characters quoted by Git may not compare correctly.

2. Preview the intended search matches before applying changes, using a line-number search that covers the same targets.

3. Apply the requested replacement using the chosen command and platform-specific syntax.

4. Verify changes were applied as intended by checking for the replacement text and confirming the expected files were changed.

## Examples

The patterns and replacements in this section are illustrative examples only; construct the search and replacement for the user's request.

### Simple Find-and-Replace

```bash
rg --hidden --null -l 'OLD' . | xargs -0 sed -i '' 's/OLD/NEW/g' # macOS / BSD sed
rg --hidden --null -l 'OLD' . | xargs -0 sed -i 's/OLD/NEW/g' # Linux / GNU sed
```

### Chaining Find-and-Replace

```bash
rg --hidden --null -l 'SEARCH_VALUE' . | xargs -0 sed -i '' -e 's/OLD/NEW/g' -e 's/ANOTHER/VALUE/g' -e 's/SEARCH/REPLACE/g' # macOS / BSD sed
rg --hidden --null -l 'SEARCH_VALUE' . | xargs -0 sed -i -e 's/OLD/NEW/g' -e 's/ANOTHER/VALUE/g' -e 's/SEARCH/REPLACE/g' # Linux / GNU sed
```

### Case-insensitive Find-and-Replace

```bash
rg --hidden --null -li 'OLD' . | xargs -0 sed -i '' 's/OLD/NEW/gI' # macOS / BSD sed
rg --hidden --null -li 'OLD' . | xargs -0 sed -i 's/OLD/NEW/gI' # Linux / GNU sed
```

### Limit matching files by type

```bash
rg --hidden --null -l 'OLD' . --type rust | xargs -0 sed -i '' 's/OLD/NEW/g' # macOS / BSD sed
rg --hidden --null -l 'OLD' . --type rust | xargs -0 sed -i 's/OLD/NEW/g' # Linux / GNU sed
```
