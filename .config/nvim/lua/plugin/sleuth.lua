return {
    "tpope/vim-sleuth",
    event = "VeryLazy",
    config = function()
        vim.cmd("silent Sleuth")
    end,
}
