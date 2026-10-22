return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- No-op for parsers already installed; the download runs async.
      require("nvim-treesitter").install({
        "bash",
        "c",
        "css",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "svelte",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      })

      -- Highlights are opt-in on the `main` branch, and so are folds.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          -- pcall: a filetype without a parser falls back to regex syntax
          if not pcall(vim.treesitter.start, args.buf) then
            return
          end

          vim.wo[0][0].foldmethod = "expr"
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldlevel = 99 -- start with everything open
        end,
      })
    end,
  },
}
