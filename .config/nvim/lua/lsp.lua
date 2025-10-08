local servers = {
  lua_ls = {},
  gopls = {},
}

local ensure_installed = vim.tbl_keys(servers)
vim.list_extend(ensure_installed, {
  'stylua',
})

require('mason-tool-installer').setup { ensure_installed = ensure_installed }

local capabilities = {} -- FIXME: more

require('mason-lspconfig').setup {
  ensure_installed = {}, -- explicitly set empty
  automatic_installation = false,
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  },
}
