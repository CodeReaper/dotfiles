local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  require 'plugin.conform',
  require 'plugin.gitsigns',
  require 'plugin.mason',
  require 'plugin.mini',
  require 'plugin.sleuth',
  require 'plugin.slides',
  require 'plugin.telescope',
  require 'plugin.tokyonight',
  require 'plugin.treesitter',
  require 'plugin.which',
}

require 'lsp'
