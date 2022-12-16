local ok, config = pcall(require, "telescope")
if not ok then
    print("ERROR: ", "telescope not found")
	return
end

config.setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}

require('telescope').load_extension('fzf')

local builtin = require("telescope.builtin")

options = { noremap = true }

vim.api.nvim_set_keymap('n', '<leader>rg', '<cmd>Telescope live_grep<cr>', options)
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', options)

vim.keymap.set('n', '<C-p>', builtin.git_files, options)
vim.keymap.set('n', '<leader>pf', builtin.find_files, options)
vim.keymap.set('n', '<leader>pb', builtin.buffers, options)
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

