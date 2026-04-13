return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            use_libuv_file_watcher = true,
            size = 13,
        })
    end,
}
