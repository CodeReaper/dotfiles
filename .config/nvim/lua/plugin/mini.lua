return {
    "nvim-mini/mini.nvim",
    config = function()
        require('mini.ai').setup { n_lines = 500 }
        require('mini.comment').setup()
        require('mini.completion').setup()
        require('mini.icons').setup { style = "ascii" }
        require('mini.move').setup()
        require('mini.pairs').setup()
        require('mini.splitjoin').setup()
        require('mini.surround').setup()

        local sl = require 'mini.statusline'
        sl.setup { use_icons = vim.g.have_nerd_font }
        ---@diagnostic disable-next-line: duplicate-set-field
        sl.section_location = function()
            return '%2l:%-2v'
        end
    end,
}
