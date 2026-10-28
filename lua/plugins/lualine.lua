-- What to call a buffer that has no file behind it.
--
-- Why this exists: nvim-tree names its own buffer `NvimTree_1`, and that is
-- literally what the statusline used to show while the tree was focused
-- (`NORMAL  opencode-dotfiles  NvimTree_1  NvimTree  18:1  62%`). A list of
-- buffer contents is not a filename, so it gets a human name instead.
-- Keyed by filetype first, then by buftype, then a generic fallback, so a new
-- special buffer shows something readable without touching this function.
local special_buffers = {
  NvimTree = "File Explorer",
  help = "Help",
  qf = "Quickfix",
  terminal = "Terminal",
  prompt = "Prompt",
  nofile = "Scratch",
}

local function special_buffer_label()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype
  local bt = vim.bo[buf].buftype

  return special_buffers[ft] or special_buffers[bt] or (ft ~= "" and ft) or "Buffer"
end

return {
  {
    "nvim-lualine/lualine.nvim",
    -- The statusline is cosmetic: it can show up after the editor is usable.
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    opts = {
      options = {
        -- Catppuccin ships this lualine theme (lua/lualine/themes/...) and it
        -- follows the configured flavour, so there is nothing to hardcode.
        theme = "catppuccin-nvim",
        -- One bar for the whole screen, matching `laststatus = 3` in options.lua
        globalstatus = true,
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        -- Left, in this order: mode, git branch (+ diff), file and diagnostics
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = {
          {
            "filename",
            path = 1, -- relative to the cwd: shorter than the full path
            symbols = {
              modified = " ●",
              readonly = " ",
              unnamed = "[No Name]",
            },
            -- Only for real files. The tree, help, quickfix and terminals
            -- have no filename, and used to leak their internal buffer name
            -- (`NvimTree_1`, `[No Name]`) into the bar.
            cond = function()
              return vim.bo.buftype == ""
            end,
          },
          {
            special_buffer_label,
            cond = function()
              return vim.bo.buftype ~= ""
            end,
          },
          "diagnostics",
        },
        -- Right: filetype, cursor position, percentage and the clock
        lualine_x = {
          {
            "filetype",
            -- "NvimTree" / "help" next to a buffer that is not a file is just
            -- repeating what lualine_c already says.
            cond = function()
              return vim.bo.buftype == ""
            end,
          },
        },
        -- `location` and `progress` replace the `ruler` we turned off in
        -- options.lua: same information, in the bar instead of a separate row.
        lualine_y = { "location", "progress" },
        lualine_z = { { "datetime", style = "%H:%M" } },
      },
    },
  },
}
