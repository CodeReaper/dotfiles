return {
  'stevearc/conform.nvim',
  opts = {
    -- RESOURCE: https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'goimports', 'gofmt' },
      tf = { 'terraform_fmt' },
      yaml = { 'yq' },
      yml = { 'yq' },
      json = { 'jq' },
      xml = { 'xmllint' }, -- FIXME: complains about no lsp
      ['*'] = {},
      ['_'] = { 'trim_whitespace' },
    },
    default_format_opts = {
      lsp_format = 'fallback',
    },
    log_level = vim.log.levels.ERROR,
    notify_on_error = true,
    notify_no_formatters = true,
  },
}
