return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'master',
  build = ':TSUpdate',
  opts = {
    ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
    auto_install = true,
  },
}
-- list of ensures?: https://arrakis.fly.dev/weeheavy/neovim/src/branch/main/lua/weeheavy/plugins/treesitter.lua
