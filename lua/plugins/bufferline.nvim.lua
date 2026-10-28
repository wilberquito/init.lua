-- Catppuccin mocha, the same palette tmux uses. Repeated here (instead of
-- asking the colourscheme for them) because catppuccin defines ZERO
-- `BufferLine*` groups: without explicit values the tabs inherit Normal /
-- Comment, end up almost the same colour as the editor and disappear.
local palette = {
  crust = "#11111b",
  surface_0 = "#313244",
  surface_2 = "#585b70",
  subtext_0 = "#a6adc8",
  lavender = "#b4befe",
  peach = "#fab387",
  red = "#f38ba8",
  blue = "#89b4fa",
  teal = "#94e2d5",
}

-- Which elements can be drawn inside a buffer tab. Every one of them exists in
-- three flavours -- plain, `_visible` (shown in a window) and `_selected` -- and
-- EVERY flavour has to be set. Bufferline derives the ones you omit from
-- `Normal`, which is how a `#161622` slab (darker than the bar) ended up after
-- each tab: that was its default close button, not a design choice.
local elements = {
  -- The empty strip behind and between the tabs. surface0 (one step lighter
  -- than the editor) is what makes the tab bar read as a separate bar instead
  -- of text floating over the code.
  fill = { bg = palette.surface_0 },
  -- `highlights.lua:163` does `hl.buffer = hl_group("buffer", "background")`:
  -- when the tab is neither visible nor selected, the NAME falls back to this
  -- group. With only a `bg` here the name kept the plugin's own #9399b2 while
  -- the modified dot used subtext_0, so a modified buffer showed TWO greys.
  background = { fg = palette.subtext_0, bg = palette.surface_0 },
  offset_separator = { fg = palette.surface_2, bg = palette.surface_0 },

  -- Padding that keeps every tab the same height/shape even without indicator
  -- or close icon. Omit it and the first cell of the bar keeps `Normal` bg.
  indicator_selected = { fg = palette.crust, bg = palette.lavender },
  indicator_visible = { fg = palette.subtext_0, bg = palette.surface_0 },

  separator = { fg = palette.surface_2, bg = palette.surface_0 },
  separator_visible = { fg = palette.surface_2, bg = palette.surface_0 },
  separator_selected = { fg = palette.surface_2, bg = palette.lavender },
}

-- Buffer name, modified dot and duplicate marker: readable grey on the strip,
-- dark on the lavender block.
--
-- `bold`/`italic` on the selected variants are explicit on purpose. Bufferline
-- sets them by default (`config.lua`, `italic = not preset.no_italic`), which is
-- why the focused tab already looked bold+italic even though this file only
-- asked for fg/bg. Left implicit, a plugin update could take them away.
for _, name in ipairs({ "buffer", "modified", "duplicate" }) do
  elements[name] = { fg = palette.subtext_0, bg = palette.surface_0 }
  elements[name .. "_visible"] = { fg = palette.subtext_0, bg = palette.surface_0 }
  elements[name .. "_selected"] = {
    fg = palette.crust,
    bg = palette.lavender,
    bold = true,
    italic = true,
  }
end

-- Diagnostics keep their semantic colour on the strip, where they read fine
-- (5.4-8.4), and go to the base ink on the lavender block.
--
-- This is not cosmetic. Bufferline EXTENDS the diagnostic highlight to the
-- buffer NAME (`diagnostics.lua:190`, `extends = { { id = ui.components.id.name
-- } }`), even though the indicator text is empty (`diagnostics.lua:183` is dead
-- code: `indicator` is already `""`, so `indicator == nil` never runs). So the
-- moment a buffer had an error, its name on the active tab was painted
-- `#f38ba8` at 1.29:1 over the lavender -- the name was the thing you could not
-- read, and the modified dot next to it stayed dark.
--
-- No colour can fix that: measured on #b4befe, every accent here lands at
-- 1.0-1.3, latte's darker variants at 1.7-3.0, and darkening the mocha accents
-- until they reach AA (60-70%) turns them into four indistinguishable brown
-- greys. The only legible answer is the ink the tab already uses.
for name, fg in pairs({
  diagnostic = palette.subtext_0,
  error = palette.red,
  warning = palette.peach,
  info = palette.blue,
  hint = palette.teal,
}) do
  elements[name] = { fg = fg, bg = palette.surface_0 }
  elements[name .. "_visible"] = { fg = fg, bg = palette.surface_0 }
  elements[name .. "_selected"] = { fg = palette.crust, bg = palette.lavender }
end

-- The generic diagnostic dot is not semantic (no error, no warning): on the
-- lavender block it has to be dark to stay readable.
elements.diagnostic_selected = {
  fg = palette.crust,
  bg = palette.lavender,
  bold = true,
  italic = true,
}

return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      -- The offset label ("File Explorer") is a plain highlight group name, so
      -- it has to exist. Re-applied on ColorScheme because switching the theme
      -- clears it.
      local function set_offset_label()
        vim.api.nvim_set_hl(0, "BufferLineOffsetLabel", {
          fg = palette.subtext_0,
          bg = palette.surface_0,
        })
      end
      set_offset_label()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = set_offset_label })

      -- Bufferline paints every tab icon with the filetype's devicon colour
      -- (`set_icon_highlight`). Measured on the lavender block, those colours
      -- are unreadable: txt 1.09, py 1.06, lua 1.61, unnamed buffer 2.31 -- the
      -- icon was invisible on the ACTIVE tab in every situation, not just when
      -- a file was modified.
      --
      -- `options.color_icons = false` looks like the fix and is a trap: it writes
      -- `fg = "NONE"` (`highlights.lua:107`), and "NONE" does not inherit the
      -- tab's ink, it falls back to `Normal` -- #cdd6f4 at 1.24, worse than
      -- before.
      --
      -- The groups are created per filetype AT RENDER TIME and cached forever
      -- (`highlights.lua:105`), so sweeping them from an autocmd is a race we
      -- lose: when the event fires the group either does not exist yet or
      -- already carries the devicon colour, and nothing re-runs afterwards.
      -- (Measured: after a BufAdd/BufEnter sweep the .py still showed 1.06.)
      -- So the creation itself is wrapped. `ui.lua:238` resolves
      -- `highlights.set_icon_highlight` through bufferline's lazy proxy on every
      -- render, which re-reads the module table -- replacing it here is enough.
      -- Calling nvim_set_hl from inside the render is exactly what the plugin
      -- already does, so it is safe.
      --
      -- Only the fg moves: the lavender bg (selected) and the strip bg
      -- (inactive) are already right. Inactive tabs keep their filetype colour,
      -- where they read 4.36-7.69 and are free information.
      local unified_icons = {}
      local function unify_icon_ink()
        local highlights = require("bufferline.highlights")
        if type(highlights.set_icon_highlight) ~= "function" then
          return -- API changed: leave the icons alone instead of breaking render
        end

        local create = highlights.set_icon_highlight
        highlights.set_icon_highlight = function(...)
          local group = create(...)
          if group and not unified_icons[group] then
            unified_icons[group] = true
            if group:match("Selected$") then
              local current = vim.api.nvim_get_hl(0, { name = group })
              -- `nvim_get_hl` hands back `default = true` (bufferline creates the
              -- group with `themable`, `highlights.lua:65`), and `nvim_set_hl`
              -- with `default = true` silently does NOTHING to an existing
              -- group -- measured: set returns ok, fg stays. Forcing it false is
              -- the whole fix. Drop ctermfg too, or a non-truecolor terminal
              -- keeps the devicon colour.
              current.ctermfg = nil
              vim.api.nvim_set_hl(0, group,
                vim.tbl_extend("force", current, { fg = palette.crust, default = false }))
            end
          end
          return group
        end
      end

      require("bufferline").setup({
        options = {
          mode = "buffers",
          diagnostics = "nvim_lsp",

          -- Thin bars instead of the powerline slants: the same quiet `|` that
          -- separates the tmux tabs. No triangles, no pills.
          separator_style = "thin",
          -- The lavender block already marks the active tab; an extra underline
          -- underneath it is noise.
          indicator = { style = "none" },

          -- One datum per tab, like tmux: the name. The close ✕ on every tab
          -- was two extra cells of noise (and the only element still using a
          -- colour outside the palette). `<leader>x` closes a buffer.
          show_buffer_close_icons = false,
          show_close_icon = false,
          always_show_bufferline = true,

          offsets = {
            {
              filetype = "NvimTree",
              -- Not "Explorer", not `NvimTree_1`: the name of the thing.
              text = "File Explorer",
              -- A dedicated group instead of "Directory": Directory has no bg,
              -- so the offset area fell back to mantle and cut a darker notch
              -- out of the tab strip. This one matches the strip exactly.
              highlight = "BufferLineOffsetLabel",
              separator = true,
            },
          },
        },

        highlights = elements,
      })

      -- After setup, so the module is loaded and the wrapper is already in place
      -- before the first tab is drawn.
      unify_icon_ink()
      -- A colorscheme throws the icon groups away and recreates them on the next
      -- render: forget what was fixed so the wrapper touches them again.
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          unified_icons = {}
        end,
      })

      vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>",
        { desc = "Next buffer" })
      vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>",
        { desc = "Previous buffer" })
    end,
  },
}
