return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        local MacroStatus = require("config.lualine-macro")
        local CountChars = require("config.count-chars")

        require("lualine").setup({
            options = { theme = "nightfly" },

            sections = {
                lualine_b = {
                    "filename",
                    "diff",
                    CountChars.char_count,
                },

                lualine_c = {
                    MacroStatus,
                },

                lualine_x = {
                    "%S",
                    "encoding",
                    "fileformat",
                    "filetype",
                },
            },
        })
    end,
}
