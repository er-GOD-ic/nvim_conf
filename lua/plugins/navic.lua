return {
    "SmiteshP/nvim-navic",
    config = function()
        local navic = require("nvim-navic")

        vim.lsp.config("lua_ls", {
            on_attach = function(client, bufnr)
                navic.attach(client, bufnr)
            end,
        })

        require("nvim-navic").setup()
        vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    end,
}
