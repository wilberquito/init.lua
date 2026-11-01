return {
  {
    "mikavilpas/yazi.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },

    -- Naming is the same as the shell: `n` opens yazi in the shell,
    -- <leader>n opens it on nvim's cwd, <leader>N on the file under the
    -- cursor. The tree keeps <leader>t, so no key means two things.
    keys = {
      -- <leader>n is a LEAF on purpose. Mapping <leader>n AND a longer
      -- <leader>nX would make every <leader>n wait timeoutlen (400ms) to see
      -- if the second key is coming — the same trap documented for `q:` in
      -- config/keymaps.lua. Never turn this into a prefix.
      {
        "<leader>n",
        "<cmd>Yazi cwd<cr>",
        desc = "Navigate: yazi in cwd",
      },
      {
        "<leader>N",
        "<cmd>Yazi<cr>",
        desc = "Navigate: yazi at current file",
      },
    },

    opts = {
      -- `nvim .` keeps opening netrw. Flip this to true to hand directory
      -- buffers to yazi instead — but then also set vim.g.loaded_netrwPlugin = 1
      -- in `init`, otherwise netrw loads first and wins.
      open_for_directories = false,

      -- No image previews in here, on purpose and by design: nvim's built-in
      -- :term supports no graphics protocol, so yazi falls back to chafa. Run
      -- `n` in Ghostty/Kitty for thumbnails; the plugin is for navigation.
    },
  },
}
