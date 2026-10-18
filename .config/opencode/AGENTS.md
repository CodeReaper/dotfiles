# Shell command guidance

Do not install tooling unless *explicitly* requested by the user.

Do not use Python, Node, Ruby, or Perl for ad hoc scripting unless *explicitly* requested by the user.
These runtimes may be used to run build, test, lint, or format commands already configured by the project.
This exception does not permit one-off scripts for inspecting, validating, or modifying files.

Use web tools for fetching URLs and searching the web rather than shell commands such as curl or wget.

For text processing, prefer:

- sed
- rg
- jq
- yq
