local nr_opts = { noremap = true }
local opts = { noremap = true, silent = true }

local map = vim.api.nvim_set_keymap

-- Change panes on vim ctrl mappings
map('n', '<C-h>', '<C-w>h', nr_opts)
map('n', '<C-j>', '<C-w>j', nr_opts)
map('n', '<C-k>', '<C-w>k', nr_opts)
map('n', '<C-l>', '<C-w>l', nr_opts)

-- Split panes
map('n', '<leader>sh', ':split<CR>', opts)
map('n', '<leader>sv', ':vsplit<CR>', opts)

-- Save
map("n", "<leader>fs", ":w<CR>", nr_opts)
map("n", "<leader>fr", ":source $MYVIMRC<CR>", nr_opts)

-- Quit
map("n", "<leader>fk", ":wq<CR>", nr_opts)
map("n", "<leader>fu", ":q!<CR>", nr_opts)

-- Move lines up/down
map("v", "<S-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<S-k>", ":m '<-2<CR>gv=gv", opts)

-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Escape maps to a rolling jk
-- map('i', 'jk', '<ESC>', nr_opts)

-- Center result search
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)

-- Move between paragraphs
map("n", "}", "{", opts)
map("n", "{", "}", opts)
map("v", "}", "{", opts)
map("v", "{", "}", opts)

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)

