-- leader mapping
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.tabstop = 4           -- Number of spaces a tab counts for
vim.opt.shiftwidth = 4        -- Spaces used for autoindent
vim.opt.softtabstop = 4       -- Spaces inserted when pressing Tab

-- Where the fuck I am
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Moving content around without tok
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Smart search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

-- Indenting
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Quality of life
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400
vim.opt.splitkeep = "screen"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Ask before quitting with unsaved changes
vim.opt.confirm = true

-- Keep the undo history in memory, so `u` reaches across buffer reloads
vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
  group = vim.api.nvim_create_augroup("options", { clear = true }),
  callback = function()
    vim.o.undolevels = vim.o.undolevels
  end,
})

local map_opts = { noremap = true, silent = true }

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", map_opts, { desc = desc }))
end

-- Window navigation
map("n", "<C-h>", "<C-w>h", "Window left")
map("n", "<C-j>", "<C-w>j", "Window down")
map("n", "<C-k>", "<C-w>k", "Window up")
map("n", "<C-l>", "<C-w>l", "Window right")

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlight")

-- Save and close
map("n", "<leader>w", "<cmd>write<CR>", "Write buffer")
map("n", "<leader>q", "<cmd>quit<CR>", "Quit window")

-- Repeat the last f/t motion
map("n", "g;", ";;", "Repeat last find")

-- Diagnostics
map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")

-- clipboard configuration for remote ssh connections
if os.getenv("SSH_CONNECTION") then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end
