return {
    -- "ergodice/hamal.nvim",
    dir = "~/.config/nvim-plugins/hamal.nvim",
    enabled = true,
    config = function()
        local hamal = require("hamal")

        -- keymaps
        vim.keymap.set("n", "<cr>", hamal.split)
        vim.keymap.set("v", "<cr>", hamal.split)
        vim.keymap.set("o", "<cr>", hamal.split)

        hamal.setup({
            quit_on_unmapped_keys = true,
        })
    end,
}
