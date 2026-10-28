return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,

        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                -- Only integrations that actually exist in catppuccin. Highlight
                -- groups for treesitter and native LSP are always applied; they
                -- are not opt-in flags.
                integrations = {
                    telescope = true,
                    gitsigns = true,
                    nvimtree = true,
                    which_key = true,
                    blink_cmp = true,
                },
            })

            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
