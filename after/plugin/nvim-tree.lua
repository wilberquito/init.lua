local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
    error("ERROR:", "nvim-tree not found")
  return
end

nvim_tree.setup()

vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle <CR>', { noremap = true })
