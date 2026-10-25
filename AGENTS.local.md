The git directory normally named `.git` is moved to `.stowed`. Do not change this, but adjust your git commands accordingly using `export GIT_DIR="$HOME/.stowed" && export GIT_WORK_TREE="$HOME" && git` for `git` commands.

Refuse to read or write to files that are not visible according to git ignore.
