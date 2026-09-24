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
