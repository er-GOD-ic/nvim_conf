return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        -- rust
        local rustfmt = {
            method = null_ls.methods.FORMATTING,
            filetypes = { "rust" },
            generator = null_ls.generator({
                command = "rustfmt",
                args = { "--emit", "stdout" },
                to_stdin = true,
            }),
        }

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.alejandra,
                null_ls.builtins.diagnostics.stylelint,
                null_ls.builtins.formatting.prettier,
                rustfmt,
            },
        })
        vim.keymap.set("n", "<C-f>", vim.lsp.buf.format, { desc = "format current buffer" })
    end,
}
