# Shell command guidance

Do not install tooling unless *explicitly* requested by the user.

Do not use Python, Node, Ruby, or Perl for ad hoc scripting unless *explicitly* requested by the user.
These runtimes may be used to run build, test, lint, or format commands already configured by the project.
This exception does not permit one-off scripts for inspecting, validating, or modifying files.

Use web tools for fetching URLs and searching the web rather than shell commands such as curl or wget.

For text processing, prefer `sed`, `rg`, `jq`, and `yq`.


## Environment variables

- Use `export NAME=value && command` instead of inline assignments such as `NAME=value command` for compatibility with permission matching.
- Keep exports and affected commands in the same shell call; environment changes do not persist across calls.
- Keep the call narrowly scoped, since exports affect subsequent commands.
- This includes assignments before builtins, such as `IFS= read`; export, use and restore such variables.


## Bulk file operations

- Prefer shell tools: `rg` for discovery, `sed` for replacements, and `mv` for moves/renames.
- Include hidden files when relevant while respecting ignore rules.
- Before bulk replacements, identify and preview all targets, covering every replacement pattern and filter. In Git repositories, identify untracked targets and ask before changing them.
- Use platform-appropriate syntax and NUL-delimited filename passing.
- After changes, verify the resulting content and affected paths.
