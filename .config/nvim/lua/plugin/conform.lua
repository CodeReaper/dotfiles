return {
  'stevearc/conform.nvim',
  config = function()
    require('conform').setup {
      -- RESOURCE: https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'goimports', 'gofmt' },
        tf = { 'terraform_fmt' },
        yaml = { 'prettier' },
        yml = { 'prettier' },
        json = { 'prettier' },
        xml = { 'xmllint' }, -- FIXME: complains about no lsp, same for prettier
        ['*'] = {},
        ['_'] = { 'trim_whitespace' },
      },
      default_format_opts = {
        lsp_format = 'fallback',
      },
      log_level = vim.log.levels.ERROR,
      notify_on_error = true,
      notify_no_formatters = true,
      format_after_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { lsp_format = 'fallback' }
      end,
    }

    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true,
    })
    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable autoformat-on-save',
    })
  end,
}
