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

-- Remap x command to black hole register.
map({ 'n', 'v' }, 'x', '"_x', { desc = 'Change the register of the `x` command to the black hole register' })
-- Remap y command to use system clipboard.
map({ 'n', 'v' }, 'y', '"+y', { desc = 'Change the register of the `y` command to the system clipboard' })
