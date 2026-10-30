-- One list, two callers: this spec and the headless bootstrap.
local languages = require("config.treesitter").languages

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- The `main` branch compiles parsers by shelling out to the external
      -- `tree-sitter` CLI, so without it every language fails on every start
      -- and the only trace is :TSLog (the log lives in memory).
      --
      -- The CLI is a program: install/nvim.sh (macOS/Arch) or npm (older APT /
      -- DNF distros) provides it. The parsers are downloaded files and are
      -- built by script/bootstrap. Here we only fill in whatever is missing,
      -- and stay quiet when the CLI is absent (offline box, cluster, CI).
      if vim.fn.executable("tree-sitter") == 1 then
        require("nvim-treesitter").install(languages)
      end

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
