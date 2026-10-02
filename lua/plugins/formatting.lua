return {
  {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    -- BufReadPost as well, otherwise lazy.nvim only loads us *after* the first
    -- BufWritePre has fired and the first save of a session never formats.
    event = { "BufReadPost", "BufWritePre" },
    dependencies = { "nvim-lua/plenary.nvim" },

    opts = {
      formatters_by_ft = {
        python = { "black" },
        sh = { "trimmed" },
        bash = { "trimmed" },
        markdown = { "trimmed" },
        yaml = { "trimmed" },
      },

      formatters = {
        black = { options = { quiet = true } },
      },

      -- Only format filetypes we actually have a formatter for, so we never
      -- prompt for a missing binary.
      format_on_save = function(buf)
        if vim.b[buf].skip_formatting then
          return false
        end

        local ft = vim.bo[buf].filetype
        if not vim.tbl_contains({ "python", "sh", "bash", "markdown", "yaml" }, ft) then
          return false
        end

        return { timeout_ms = 1000, lsp_format = "fallback" }
      end,

      lsp_format = "fallback",
    },

    keys = {
      {
        "<leader>f",
        function()
          require("conform").format_sync({ async = true, lsp_format = "fallback" })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
      {
        "<leader>fi",
        function()
          require("conform").format_info()
        end,
        mode = { "n" },
        desc = "Formatter info",
      },
    },
  },
}
