local map = vim.keymap.set

-- RESOURCE: https://vim.rtorr.com - cheat sheet

-- Join lines
map("n", "J", "mzJ`z")

-- Better move
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- Better search
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- escape the terminal
map('t', '<Esc>', '<C-\\><C-n>')

-- remove the pain
map('n', 'q', '<Nop>', { desc = 'Disable recording' })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

