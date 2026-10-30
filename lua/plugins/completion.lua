return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "*",
    -- optional: snippets for the snippet source
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      -- The 'default' preset already gives us:
      --   <C-Space> show menu + docs, <C-y> accept, <C-n>/<C-p> move,
      --   <C-k> signature. Its <Tab>/<S-Tab> only jump snippets, so they are
      --   overridden below with the VS Code flow.
      keymap = {
        preset = "default",

        -- Menu visible -> cycle the list (blink wraps around by default, since
        -- completion.list.cycle.from_top/from_bottom are true). Menu hidden ->
        -- jump snippet placeholders, then fall through to a normal tab. Every
        -- command returns early when it does not apply, so the chain degrades
        -- instead of swallowing the key.
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

        -- Accept the highlighted item. `completion.list.selection.preselect`
        -- defaults to true, so the first candidate is already highlighted while
        -- the menu is up (its inline preview only appears once you move with
        -- <Tab>, since `auto_insert` follows an explicit selection).
        -- `select_and_accept` also covers a list opened manually via <C-space>;
        -- with no menu, `fallback` gives us a plain newline.
        ["<CR>"] = { "select_and_accept", "fallback" },
      },

      appearance = {
        nerd_font_variant = "nerd_font",
      },

      sources = {
        -- 'snippets' is in blink's own default; leaving it out disables it
        default = { "lsp", "path", "snippets", "buffer" },
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
          -- `border` goes inside `window`: blink validates the shape and a
          -- top-level `documentation.border` is an "Unexpected field in
          -- configuration" (lua/blink/cmp/config/completion/documentation.lua).
          window = {
            border = "rounded",
          },
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
