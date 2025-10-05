local map = vim.keymap.set

-- https://vim.rtorr.com - cheat sheet

map("n", "J", "mzJ`z")

map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

map('t', '<Esc>', '<C-\\><C-n>')
