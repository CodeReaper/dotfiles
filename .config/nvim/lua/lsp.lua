-- RESOURCE: https://github.com/neovim/nvim-lspconfig/tree/master/lsp
local servers = {
  -- alloy_ls = {}, -- not part of mason-lsp yet
  ansiblels = {},
  azure_pipelines_ls = {},
  bashls = {},
  roslyn = {},
  docker_language_server = {},
  gh_actions_ls = {},
  gopls = {},
  helm_ls = {},
  jqls = {},
  jsonls = {},
  lua_ls = {},
  marksman = {}, -- markdown
  nginx_language_server = {},
  systemd_ls = {},
  templ = {},
  terraformls = {},
  yamlls = {},
}

local ensure_installed = vim.tbl_keys(servers)
vim.list_extend(ensure_installed, {
  'checkmake',
  'editorconfig-checker',
  'hadolint',
  'jq',
  'markdownlint',
  'prettier',
  'shellcheck',
  'stylua',
  'yamllint',
})

require('mason-tool-installer').setup { ensure_installed = ensure_installed }

local capabilities = require('blink.cmp').get_lsp_capabilities()

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

for server, config in pairs(servers) do
  config.capabilities = vim.tbl_deep_extend('force', capabilities, config.capabilities or {})
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end
