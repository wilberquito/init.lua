return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      local api = require("nvim-tree.api")

      require("nvim-tree").setup({
        -- One cwd for everything. config/autocmds.lua pins the global cwd to
        -- the buffer's git root; the tree follows it, and moving the tree root
        -- (`-`, <C-]>) does a global `:cd` instead of the default window-local
        -- `:lcd` — otherwise Telescope, run from the code window, kept
        -- searching the old, deeper folder.
        sync_root_with_cwd = true,
        respect_buf_cwd = true,

        -- Close the tree once the file is open, so <leader>t from the tree lands
        -- straight in the code. <leader>t brings the tree back.
        actions = {
          open_file = {
            quit_on_open = true,
          },
          change_dir = {
            global = true,
          },
        },

        -- Open tree to the right
        view = {
          side = "right",
        },

        -- Keep the tree cursor on the file of the current buffer, expanding the
        -- parent folders. The root is left alone, so the tree comes back to the
        -- folder you were browsing instead of jumping to the opened file.
        update_focused_file = {
          enable = true,
          exclude = function(args)
            return not vim.api.nvim_buf_is_valid(args.buf) or vim.bo[args.buf].buftype ~= ""
          end,
          update_root = {
            enable = false,
          },
        },

        on_attach = function(bufnr)
          api.config.mappings.default_on_attach(bufnr)

          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          -- Vim-style tree walking, folders only (<CR> opens files):
          --   l: expand a closed folder, step into an open one.
          --   h: collapse an open folder, otherwise jump to the parent and
          --      collapse it.
          vim.keymap.set("n", "l", function()
            local node = api.tree.get_node_under_cursor()
            if not node or node.type ~= "directory" then
              return
            end
            if node.open then
              vim.cmd("normal! j")
            else
              api.node.open.edit()
            end
          end, opts("Expand folder"))

          vim.keymap.set("n", "h", function()
            local node = api.tree.get_node_under_cursor()
            if not node then
              return
            end
            if node.type == "directory" and node.open then
              api.node.open.edit()
            else
              api.node.navigate.parent_close()
            end
          end, opts("Collapse folder / go to parent"))
        end,
      })

      local last_win = nil

      -- `t` for tree. Not `e`: in the shell `e` is `$EDITOR`, and here <leader>n
      -- is navigation (yazi), so the letters mean one thing across both worlds.
      vim.keymap.set("n", "<leader>t", function()
        local tree_win = api.tree.winid()

        if tree_win == nil or tree_win ~= vim.api.nvim_get_current_win() then
          last_win = vim.api.nvim_get_current_win()
          api.tree.open()
        else
          -- Leave the tree BEFORE closing it: api.tree.close() while the tree
          -- holds focus makes nvim pick a neighbour for us. This mirrors what
          -- quit_on_open does — it closes through view.close() -> this tab only
          -- (tab.sync.close is false by default), not every tab.
          if last_win and vim.api.nvim_win_is_valid(last_win) then
            vim.api.nvim_set_current_win(last_win)
          end
          api.tree.close()
        end
      end, {
        desc = "Toggle focus file tree",
      })
    end,
  },
}
