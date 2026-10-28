return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,

        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                -- Un escalon mas abajo que `base`, sin inventar ningun color:
                -- `crust` #11111b ya existe en la paleta y no lo estabamos
                -- usando en ningun lado. Medido con el texto #cdd6f4:
                -- 11.34 sobre #1e1e2e -> 12.97 sobre #11111b, y los acentos
                -- suben lo mismo (red 7.08->8.10, blue 8.12->8.91).
                --
                -- `mantle` NO se toca: los floats y la barra de tmux quedan a
                -- 1.07 del editor, igual que antes. Lo unico que cambia de
                -- lugar en la jerarquia es el strip de tabs, que sigue siendo
                -- surface0 #313244: contra crust pasa de 1.30 a 1.49.
                color_overrides = {
                    mocha = {
                        base = "#11111b",
                    },
                },
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
