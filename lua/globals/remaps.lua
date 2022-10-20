local options = { noremap = true }
local cmd_options = { noremap = true, silent = true }

local map = vim.api.nvim_set_keymap

-- Change panes on vim ctrl mappings
map('n', '<C-h>', '<C-w>h', options)
map('n', '<C-j>', '<C-w>j', options)
map('n', '<C-k>', '<C-w>k', options)
map('n', '<C-l>', '<C-w>l', options)

-- Move lines up/down
map("v", "<C-j>", ":m '>+1<CR>gv=gv", cmd_options)
map("v", "<C-k>", ":m '<-2<CR>gv=gv", cmd_options)

-- Escape maps to a rolling jk
map('i', 'jk', '<ESC>', options)
