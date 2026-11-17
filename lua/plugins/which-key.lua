return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- Group names, so the popup after <leader> reads as a menu instead of a
      -- list of bare letters.
      spec = {
        { "<leader>f", group = "Find" },
        { "<leader>c", group = "Code" },
        { "<leader>r", group = "Refactor" },
        { "<leader>h", group = "Git hunks" },
        { "<leader>l", group = "LSP / diagnostics" },
      },
    },
  },
}
