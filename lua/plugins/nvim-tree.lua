return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      local api = require("nvim-tree.api")

      require("nvim-tree").setup({
        -- Keep the tree cursor on the file of the current buffer, expanding the
        -- parent folders, and move the root when the file is outside of it.
        update_focused_file = {
          enable = true,
          exclude = function(args)
            return not vim.api.nvim_buf_is_valid(args.buf) or vim.bo[args.buf].buftype ~= ""
          end,
          update_root = {
            enable = true,
          },
        },

        on_attach = function(bufnr)
          api.config.mappings.default_on_attach(bufnr)
        end,
      })

      local last_win = nil

      vim.keymap.set("n", "<leader>e", function()
        local tree_win = api.tree.winid()

        if tree_win == nil or tree_win ~= vim.api.nvim_get_current_win() then
          last_win = vim.api.nvim_get_current_win()
          api.tree.open()
        else
          if last_win and vim.api.nvim_win_is_valid(last_win) then
            vim.api.nvim_set_current_win(last_win)
          else
            vim.cmd("wincmd p")
          end
        end
      end, {
        desc = "Toggle focus file tree",
      })
    end,
  },
}
