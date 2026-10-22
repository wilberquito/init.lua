-- leader mapping
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Colours: kept here so the theme never depends on another plugin loading first
vim.opt.termguicolors = true

vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.tabstop = 4           -- Number of spaces a tab counts for
vim.opt.shiftwidth = 4        -- Spaces used for autoindent
vim.opt.softtabstop = 4       -- Spaces inserted when pressing Tab

-- Where the fuck I am
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Smart search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

-- Indenting
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Splits and statusline: always the same layout, one bar for the whole screen
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.laststatus = 3

-- Quality of life
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400
vim.opt.splitkeep = "screen"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.pumheight = 10        -- the completion menu never eats half the screen
vim.opt.wildoptions = "pum"   -- `:` completion in a popup
vim.opt.shortmess:append("c") -- no "Press ENTER" for every message
vim.opt.signcolumn = "yes"    -- never shift text when signs appear

-- Ask before quitting with unsaved changes
vim.opt.confirm = true

-- No wrap text for fiting in view
vim.opt.wrap = false

-- Show tabs and trailing spaces without being obnoxious about it
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Rounded borders on every floating window: hover, diagnostics, pickers, ...
vim.o.winborder = "rounded"

-- Diagnostics: sorted by severity, readable float that says who is complaining
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = { spacing = 2, prefix = "●" },
  float = { border = "rounded", source = true },
})

-- Keep the undo history in memory, so `u` reaches across buffer reloads
vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
  group = vim.api.nvim_create_augroup("options", { clear = true }),
  callback = function()
    vim.o.undolevels = vim.o.undolevels
  end,
})

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
