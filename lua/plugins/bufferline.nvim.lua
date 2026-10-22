return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          diagnostics = "nvim_lsp",
          separator_style = "thin",
          show_buffer_close_icons = true,
          show_close_icon = false,
          always_show_bufferline = true,
          offsets = {
            {
              filetype = "NvimTree",
              text = "Explorer",
              highlight = "Directory",
              separator = true,
            },
          },
        },
      })

      vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>",
        { desc = "Next buffer" })
      vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>",
        { desc = "Previous buffer" })
    end,
  },
}
