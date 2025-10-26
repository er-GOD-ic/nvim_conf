return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            window = {
                position = "right",
                mappings = {
                    ["l"] = "open",
                    ["h"] = "close_node",
                    ["<space>"] = "none",
                },
            },
            follow_current_file = { enabled = false },
            group_empty_dirs = false,
        })
        vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle filesystem right<CR>", { desc = "Toggle Neo-tree" })
        vim.keymap.set("n", "<C-S-e>", "<cmd>Neotree focus<CR>", { desc = "Focus Neo-tree" })
    end,
}
