return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = 13,
        })

        vim.keymap.set("t", "<CR>", function()
            -- まず Enter を端末へ送る（通常の動作）
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)

            -- Neo-tree を非同期で更新
            vim.schedule(function()
                vim.cmd("Neotree refresh")
            end)
        end, { silent = true })
    end,
}
