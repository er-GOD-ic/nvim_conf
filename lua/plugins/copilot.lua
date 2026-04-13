return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            filetypes = {
               markdown = true,
            },
            suggestion = {
                enabled = true,
                auto_trigger = true, -- ← 入力中に自動表示
                keymap = {
                    accept = "<S-Tab>", -- 候補を確定
                    next = "<M-]>", -- 次候補
                    prev = "<M-[>", -- 前候補
                    dismiss = "<C-]>", -- キャンセル
                },
            },
            panel = {
                enabled = false, -- パネルは不要なら切る
            },
        })
    end,
}
