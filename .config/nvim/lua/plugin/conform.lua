return {
    'stevearc/conform.nvim',
    opts = {
        -- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
        formatters_by_ft = {
            lua = { "stylua" },
            go = { "goimports", "gofmt" },
            rust = { "rustfmt", lsp_format = "fallback" },
            terraform = { "terraform_fmt" },
            yaml = { "yq" },
            json = { "jq" },
            dockerfile = { "dockerfmt" },
            sh = { "shellcheck" },
            makefile = { "bake" },
            mk = { "bake" },
            md = { "markdownfmt" },
            xml = { "xmllint" },
            ["*"] = {},
            ["_"] = { "trim_whitespace" },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
        log_level = vim.log.levels.ERROR,
        notify_on_error = true,
        notify_no_formatters = true,
    }
}
