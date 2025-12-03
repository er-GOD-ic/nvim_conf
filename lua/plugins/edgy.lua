return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
        bottom = {},
        left = {},
        right = {
            {
                title = " Files",
                ft = "neo-tree",
                size = { width = 50 },
                open = "Neotree left",
            },
        },
        top = {},
        keys = {},

        animate = { enabled = false },

        exit_when_last = false,
        close_when_all_hidden = true,
    },
}
