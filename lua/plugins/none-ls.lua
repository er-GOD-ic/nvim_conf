return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        local rustfmt = {
            method = null_ls.methods.FORMATTING,
            filetypes = { "rust" }, -- Rust ファイル対象
            generator = null_ls.generator({
                command = "rustfmt", -- 実行するコマンド
                args = { "--emit", "stdout" }, -- 標準出力に整形結果を出力
                to_stdin = true,   -- 標準入力から内容を渡す
            }),
        }

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.alejandra,
                null_ls.builtins.diagnostics.stylelint,
                rustfmt,
            },
        })
        vim.keymap.set("n", "<C-f>", vim.lsp.buf.format, { desc = "format current buffer" })
    end,
}
