return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            -- open_mapping = [[<leader>t]],
            use_libuv_file_watcher = true,
            size = 13,
            direction = 'float',
            float_opts = {
                border = 'curved',
                title_pos = 'left',
            },
        })

        vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>")
        vim.api.nvim_create_autocmd("TermOpen", {
            callback = function(args)
                vim.keymap.set("n", "q", "<cmd>q<CR>", { buffer = args.buf, silent = true })
            end,
        })
    end,
}
