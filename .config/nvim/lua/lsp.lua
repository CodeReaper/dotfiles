local servers = {
  gopls = {},
  jsonls = {},
  lua_ls = {},
}

local ensure_installed = vim.tbl_keys(servers)
vim.list_extend(ensure_installed, {
  'stylua',
})

require('mason-tool-installer').setup { ensure_installed = ensure_installed }

local capabilities = vim.lsp.protocol.make_client_capabilities()

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
