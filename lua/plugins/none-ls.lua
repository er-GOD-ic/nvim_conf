return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.alejandra
            },
        })
        vim.keymap.set("n", "<C-f>", vim.lsp.buf.format, { desc = "format current buffer" })
    end,
}
