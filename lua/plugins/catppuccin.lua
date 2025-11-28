return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        vim.opt.guicursor = {
            "n:block-Cursor",
            "v:block-CursorVisual",
            "c:block-Cursor",
            "i:ver25-Cursor",
        }

        require("catppuccin").setup({
            flavour = "mocha",
            transparent_background = false,

            custom_highlights = function(colors)
                return {
                    CursorVisual = { bg = colors.mauve },
                    CursorLineNr = { bg = "#2a2b3d" },
                    CursorColumn = { bg = "#2a2b3d" },
                }
            end,
        })

        vim.cmd.colorscheme("catppuccin")
    end,
}
