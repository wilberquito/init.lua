local ok, conf = pcall(require, "nvim-tree")
if not ok then
    error("ERROR - nvim-tree not found")
    return
end


conf.setup({
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})


local opts = { noremap = true, silent = true }

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle <CR>', opts)

