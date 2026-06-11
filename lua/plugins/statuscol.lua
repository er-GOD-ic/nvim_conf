return {
    "luukvbaal/statuscol.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- 依存関係を明示
    event = "BufReadPre",
    enabled = true,
    config = function()
        local oil_cols = require("config.statuscol-oil")

        require("statuscol").setup({
            setopt = true,
            relculright = false,
            segments = {
                { text = { "%s" },           click = "v:lua.ScSa" }, -- sign
                { text = { "%l" },           click = "v:lua.ScLa" }, -- line number
                { text = { " " } },
                { text = oil_cols.permission },
                { text = oil_cols.icon },
            },
        })
    end,
}
