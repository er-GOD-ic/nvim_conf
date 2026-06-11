return {
    "luukvbaal/statuscol.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- 依存関係を明示
    event = "BufReadPre",
    enabled = true,
    config = function()
        local oil_cols = require("config.statuscol-oil")
        oil_cols.opts = {
            size_prefer_units = true,
            size_width = 4,
            mtime_format = "%Y-%m-%d %H:%M"
        }

        require("statuscol").setup({
            setopt = true,
            relculright = false,
            segments = {
                { text = { "%s" },           click = "v:lua.ScSa" }, -- sign
                { text = { "%l" },           click = "v:lua.ScLa" }, -- line number
                { text = { " " } },
                oil_cols.permission,
                oil_cols.whitespace,
                oil_cols.owner,
                oil_cols.whitespace,
                oil_cols.size,
                oil_cols.whitespace,
                oil_cols.icon,
            },
        })
    end,
}
