local map = vim.keymap.set

-- telescope
local builtin = require('telescope.builtin')
map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
map('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
map('n', '<leader>sa', function()
  builtin.find_files({
    hidden = true,
    no_ignore = true,
    follow = true,
  })
end, { desc = '[S]earch [A]ll files' })
map('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
map('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
map('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
-- file browser
map("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

-- format
map("n", "<leader>f", function()
    vim.lsp.buf.format()
end, { desc = "Format buffer with LSP" })
