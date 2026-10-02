return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "*",
    opts = {
      -- The 'default' preset already gives us:
      --   <C-Space> show menu + docs, <C-y> accept, <C-n>/<C-p> move,
      --   <Tab>/<S-Tab> snippets (falls through to a normal tab), <C-k> signature.
      keymap = {
        preset = "default",
      },

      appearance = {
        nerd_font_variant = "nerd_font",
      },

      sources = {
        default = { "lsp", "path", "buffer" },
      },

      fuzzy = {
        -- Avoids blink.cmp downloading prebuilt binaries on startup; we are
        -- often on a cluster without internet access.
        implementation = "lua",
      },

      completion = {
        menu = {
          border = "rounded",
        },
        documentation = {
          auto_show = true,
          border = "rounded",
        },
      },

      signature = {
        window = {
          border = "rounded",
        },
      },
    },
  },
}
