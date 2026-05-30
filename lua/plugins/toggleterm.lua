return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            use_libuv_file_watcher = true,
            size = 13,
        })

        -- keymaps
        vim.keymap.set("n", "<leader>t", function()
            require("toggleterm").toggle(1, nil, vim.fn.getcwd())
        end, {
            noremap = true,
            silent = true,
            desc = "toggle terminal",
        })
    end,
}
