return {
    "luukvbaal/statuscol.nvim",
    dependencies = { "ergodice/statuscol-oil.nvim" },
    event = "BufReadPre",
    enabled = true,
    config = function()
        local oil_cols = require("statuscol-oil")

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
