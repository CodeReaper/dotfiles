return {
    'stevearc/conform.nvim',
    opts = {
        -- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
        formatters_by_ft = {
            lua = { "stylua" },
            go = { "goimports", "gofmt" },
            rs = { "rustfmt", lsp_format = "fallback" },
            tf = { "terraform_fmt" },
            yaml = { "yq" },
            yml = { "yq" },
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
