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

-- options first: it sets the leader, and keymaps depend on it
require("config.options")
require("config.autocmds")
require("config.keymaps")

require("lazy").setup("plugins", {
    -- avoids the default-theme flash on a fresh install
    install = { colorscheme = { "catppuccin" } },
    ui = { border = "rounded" },
    -- drop plugins that were removed from specs from the runtimepath
    performance = { rtp = { reset = true } },
    -- lazy-lock.json is committed: update plugins on purpose, not on startup
    checker = { enabled = false },
})
