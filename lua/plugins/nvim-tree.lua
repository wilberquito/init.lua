return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      require("nvim-tree").setup({
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")

          local function opts(desc)
            return {
              desc = "nvim-tree: " .. desc,
              buffer = bufnr,
              noremap = true,
              silent = true,
              nowait = true,
            }
          end

          -- Default mappings
          api.config.mappings.default_on_attach(bufnr)

          -- Focus file tree
          vim.keymap.set("n", "<leader>e", function()
            if api.tree.is_visible() then
              api.tree.focus()
            else
              api.tree.open()
            end
          end, {
            desc = "Focus file tree",
          })
        end,
      })
    end,
  },
}

