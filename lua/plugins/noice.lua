return {
  {
    "folke/noice.nvim",
    -- VeryLazy on purpose: this replaces the cmdline, the messages and the
    -- popupmenu, none of which matter for the first frame of the editor.
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- nvim-notify is NOT a dependency: without it noice falls back to its own
      -- built-in `mini` notification view, and one less plugin is one less
      -- thing to break.
    },

    opts = {
      cmdline = {
        enabled = true,
        -- Centred float (50%/50% is the built-in default): you no longer have
        -- to look at the bottom of the screen to read what you are typing.
        view = "cmdline_popup",
        format = {
          -- noice ships `filter = { pattern = "^:%s*!", icon = "$", lang =
          -- "bash" }`: `:!ls` was classified as a bash filter and drew a box
          -- titled "Filter" (config/cmdline.lua:37 builds the title from the
          -- format name), instead of the normal command line.
          filter = false,
        },
      },

      messages = {
        enabled = true,
        view = "notify",
        view_error = "notify",
        view_warn = "notify",
        -- `:messages` used to dump the history at the bottom; now it opens a
        -- centred popup. `:Noice telescope` opens the same thing, searchable.
        view_history = "popup",
        -- Search counts stay out of the way, rendered next to the match.
        view_search = "virtualtext",
      },

      popupmenu = {
        enabled = true,
        backend = "nui",
      },

      -- `:!cmd` output does not go through `vim.notify`: it arrives as a
      -- `msg_show` with kind `shell_out` (or `shell_err`). The default `notify`
      -- view paints it as a toast and the `msg_clear` of the next redraw wipes
      -- it, so the output was never visible -- `cmdheight` is not the culprit,
      -- we measured both values. A split keeps it on screen like the classic
      -- message area. Both kinds, or stderr would still vanish.
      routes = {
        {
          filter = { event = "msg_show", kind = { "shell_out", "shell_err" } },
          view = "split",
        },
      },

      presets = {
        -- Keeps the cmdline and its completion popup glued together, so the
        -- completion does not float somewhere else than what you type.
        command_palette = true,
        -- Long messages go to a split instead of covering the screen.
        long_message_to_split = true,
        -- Rounded border on LSP hover/signature docs, like `winborder` does for
        -- every other float in options.lua.
        lsp_doc_border = true,
      },

      views = {
        cmdline_popup = {
          position = { row = "50%", col = "50%" },
          size = { width = 60, height = "auto" },
        },

        -- `:messages` / `:Noice` history. The default popup is a fixed 120
        -- columns, which on a normal terminal is the whole screen; a
        -- percentage keeps it a readable box.
        popup = {
          size = { width = "80%", height = "60%" },
        },

        -- The `mini` view is the notification fallback noice uses when
        -- nvim-notify/snacks are not installed. Its default is the bottom
        -- right corner, which with `cmdheight = 0` means covering the last
        -- line of code. Top right instead: out of the way and off the
        -- statusline.
        mini = {
          position = { row = 1, col = "100%" },
        },
      },
    },
  },
}
