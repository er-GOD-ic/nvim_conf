return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local MacroStatus = require("config.lualine-macro")
        require("lualine").setup({
            options = { theme = "nightfly" },
            sections = {
                lualine_b = { "filename", "diff" },
                lualine_c = { MacroStatus },
            },
        })
    end,
}
