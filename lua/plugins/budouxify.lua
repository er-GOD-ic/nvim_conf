return {
    "atusy/budouxify.nvim",
    dependencies = { "atusy/budoux.lua" },
    enabled = false,
    config = function()
        vim.keymap.set("n", "w", function()
            local pos = require("budouxify.motion").find_forward({ head = true })
            if pos then
                vim.api.nvim_win_set_cursor(0, { pos.row, pos.col })
            end
        end)
        vim.keymap.set("n", "e", function()
            local pos = require("budouxify.motion").find_forward({ head = false })
            if pos then
                vim.api.nvim_win_set_cursor(0, { pos.row, pos.col })
            end
        end)
        vim.keymap.set("n", "b", function()
            local pos = require("budouxify.motion").find_backward({ head = true })
            if pos then
                vim.api.nvim_win_set_cursor(0, { pos.row, pos.col })
            end
        end)
    end,
}
