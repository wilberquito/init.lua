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
        -- "trimmed" is not a conform formatter; the real names are
        -- trim_whitespace / trim_newlines.
        sh = { "trim_whitespace" },
        bash = { "trim_whitespace" },
        markdown = { "trim_whitespace" },
        yaml = { "trim_whitespace" },
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

    -- Under <leader>c (code), next to <leader>ca. Not <leader>f: that is the
    -- prefix of every Telescope picker, and a mapping on the prefix itself makes
    -- each <leader>f… wait `timeoutlen` for a possible second key.
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
      {
        "<leader>ci",
        "<cmd>ConformInfo<CR>",
        mode = { "n" },
        desc = "Formatter info",
      },
    },
  },
}
