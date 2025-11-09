return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
        bottom = {},
        left = {},
        right = {
            {
                title = " Files",
                ft = "neo-tree", -- ファイルタイプで識別
                size = { width = 40 },
                open = "Neotree left", -- edgy が呼び出すコマンド
            },
        },
        top = {},
        keys = {},

        animate = { enabled = false },
    },
}
