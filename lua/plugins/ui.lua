return {
  -- vim.ui.select / vim.ui.input with a real picker instead of the cmdline.
  -- Every code action, rename and LSP prompt goes through these.
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
