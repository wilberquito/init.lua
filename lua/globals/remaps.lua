local options = { noremap = true }
local cmd_options = { noremap = true, silent = true }

local map = vim.api.nvim_set_keymap

-- Change panes on vim ctrl mappings
map('n', '<C-h>', '<C-w>h', options)
map('n', '<C-j>', '<C-w>j', options)
map('n', '<C-k>', '<C-w>k', options)
map('n', '<C-l>', '<C-w>l', options)

-- Save
map("n", "<leader>fs", ":w<CR>", options)
map("n", "<leader>fr", ":source $MYVIMRC<CR>", options)

-- Move lines up/down
map("v", "<C-j>", ":m '>+1<CR>gv=gv", cmd_options)
map("v", "<C-k>", ":m '<-2<CR>gv=gv", cmd_options)

-- Escape maps to a rolling jk
map('i', 'jk', '<ESC>', options)

-- Center result search
map("n", "n", "nzz", cmd_options)
map("n", "N", "Nzz", cmd_options)

-- Easy way to enter in command instructions
map("n", ";", ":", cmd_options)
map("n", ":", ";", cmd_options)


