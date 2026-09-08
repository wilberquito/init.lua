local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"

    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- leader mapping
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.tabstop = 4           -- Number of spaces a tab counts for
vim.opt.shiftwidth = 4        -- Spaces used for autoindent
vim.opt.softtabstop = 4       -- Spaces inserted when pressing Tab


require("lazy").setup("plugins")



