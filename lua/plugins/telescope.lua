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
                -- Hidden files: dotfiles and .github/ are usually what we are
                -- looking for. But `--hidden` also walks .git/ (objects, hooks,
                -- modules): in the dotfiles repo that was 860 of 942 results.
                -- .gitignore never covers .git/ itself, so exclude it here.
                function()
                    require("telescope.builtin").find_files({
                        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                    })
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
                "<leader>fm",
                function()
                    require("telescope.builtin").marks()
                end,
                desc = "Marks",
            },
            {
                "<leader>fj",
                function()
                    require("telescope.builtin").jumplist()
                end,
                desc = "Jumplist",
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
            {
                "<leader>fm",
                function()
                    require("telescope.builtin").marks()
                end,
                desc = "Marks",
            },
        },

        config = function()
            local telescope = require("telescope")

            telescope.load_extension("fzf")
            -- `:Noice telescope`: the message history, but searchable.
            telescope.load_extension("noice")

            telescope.setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                        },
                    },
                },
                pickers = {
                    -- The marks picker ships `actions.delete_mark` but maps it to
                    -- nothing. <Tab> to multi-select, then delete them all at once.
                    -- <C-d> overrides preview scrolling, but only in this picker.
                    marks = {
                        mappings = {
                            i = { ["<C-d>"] = "delete_mark" },
                            n = { ["dd"] = "delete_mark" },
                        },
                    },
                },
            })
        end,
    },
}
