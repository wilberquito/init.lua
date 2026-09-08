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
        config = function()
            telescope = require("telescope")

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


            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>ff", builtin.find_files, {
                desc = "Find files",
            })

            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {
                desc = "Live grep",
            })
        end,
    }
}
