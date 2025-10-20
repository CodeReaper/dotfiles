# notes

The neovim configuration is mostly working, but abandoned for now.

I hit the wall setting DAPs up which initially just worked, but broke after no changes to configuration and with no zombie processes.
This happened just before I was going to have handle 'run/debug test' shortcuts that needs to be different per language (and not included in DAP?).
Currently considering how to configure VSCode to more neovim-like (but without adding neovim or vim motions to it).

## Old notes
```
maybe:
- https://github.com/MeanderingProgrammer/render-markdown.nvim
- https://github.com/navarasu/onedark.nvim

brews:
 - tree-sitter-cli
 - rg
 - fd

shortcuts:
 - https://neovim.io/doc/user/motion.html

shell flags needs to be setup before installing asdf python otherwise you need to uninstall/install python again

https://github.com/EthanWng97/dotfiles/blob/main/.config/nvim/lua/plugins/lsp/lsp-utils.lua

dap:
https://tamerlan.dev/a-guide-to-debugging-applications-in-neovim/
```
