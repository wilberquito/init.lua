return {
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },

        -- Lazy-loading. The pickers only matter once you press a key, so the
        -- plugin is not required at startup. `keys` and `cmd` tell lazy what to
        -- stub; on first use it loads the plugin and then runs the action.
        cmd = "Telescope",

        keys = {
            {
                "<leader>ff",
                -- hidden: dotfiles and .github/ are usually what we are looking for
                function()
                    require("telescope.builtin").find_files({ hidden = true })
                end,
                desc = "Find files",
            },
            {
                "<leader>fg",
                function()
                    require("telescope.builtin").live_grep()
                end,
                desc = "Live grep",
            },
            {
                "<leader>fs",
                function()
                    require("telescope.builtin").grep_string()
                end,
                desc = "Grep word under cursor",
            },
            {
                "<leader>/",
                function()
                    require("telescope.builtin").current_buffer_fuzzy_find()
                end,
                desc = "Search in buffer",
            },
            {
                "<leader>fb",
                function()
                    require("telescope.builtin").buffers()
                end,
                desc = "Buffers",
            },
            {
                "<leader>fr",
                function()
                    require("telescope.builtin").resume()
                end,
                desc = "Resume last picker",
            },
            {
                "<leader>fd",
                function()
                    require("telescope.builtin").diagnostics()
                end,
                desc = "Diagnostics",
            },
            {
                "<leader>fo",
                function()
                    require("telescope.builtin").oldfiles()
                end,
                desc = "Recent files",
            },
            {
                "<leader>fh",
                function()
                    require("telescope.builtin").help_tags()
                end,
                desc = "Help tags",
            },
            {
                "<leader>fk",
                function()
                    require("telescope.builtin").keymaps()
                end,
                desc = "Keymaps",
            },
        },

        config = function()
            local telescope = require("telescope")

            telescope.load_extension("fzf")

            telescope.setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                        },
                    },
                },
            })
        end,
    },
}
