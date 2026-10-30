-- tree-sitter languages, shared by the plugin spec and the headless bootstrap.
--
-- Kept in its own module because two very different callers need the same list:
-- `lua/plugins/treesitter.lua` (opportunistic install while editing) and
-- `script/bootstrap` in the dotfiles, which builds every parser on a fresh
-- machine through a headless nvim.
local M = {}

M.languages = {
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
}

-- Builds every parser and blocks until they exist.
--
-- nvim-treesitter's own `install()` is async and returns immediately, so a
-- headless nvim would quit before the first grammar finished compiling. That is
-- why this waits on `get_installed()` instead of on the install call.
--
-- @param opts? { timeout_ms?: integer }
-- @return boolean true when every language ended up installed
function M.install_all(opts)
  opts = opts or {}

  local ts = require("nvim-treesitter")
  ts.install(M.languages)

  local function missing()
    local installed = ts.get_installed()
    return vim.tbl_filter(function(lang)
      return not vim.tbl_contains(installed, lang)
    end, M.languages)
  end

  local done = vim.wait(opts.timeout_ms or 600000, function()
    return #missing() == 0
  end, 500)

  if not done then
    vim.notify(
      "nvim-treesitter: parsers still missing: " .. table.concat(missing(), ", "),
      vim.log.levels.WARN
    )
  end

  return done
end

return M
