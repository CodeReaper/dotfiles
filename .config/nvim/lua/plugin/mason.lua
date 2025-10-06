return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = require('lsps')
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
