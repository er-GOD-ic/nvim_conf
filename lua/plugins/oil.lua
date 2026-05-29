return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,

    config = function()
        local oil = require("oil")
        oil.setup({
            default_file_explorer = true,
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            view_options = {
                show_hidden = true,
                natural_order = true,
                is_always_hidden = function(name, _)
                    return name == ".." or name == ".git"
                end,
            },
            win_options = {
                wrap = true,
            },
            float = {
                max_width = 0.9,
                max_height = 0.9,
                border = "rounded",
            },
            keymaps = {
                ["g?"] = { "actions.show_help", mode = "n" },
                ["<CR>"] = "actions.select",
                ["<C-c>"] = { "actions.toggle_trash", mode = "n" },
                ["<C-l>"] = "actions.refresh",
                ["-"] = { "actions.parent", mode = "n" },
                ["_"] = { "actions.open_cwd", mode = "n" },
                ["g."] = { "actions.toggle_hidden", mode = "n" },
            },
        })
        -- keymaps
        vim.keymap.set("n", "<leader>e", function()
            if vim.bo.filetype == "oil" and not vim.api.nvim_buf_get_name(0):match("^oil%-trash") then
                oil.close()
                if vim.api.nvim_buf_get_name(0):match("^oil%-trash") then
                    oil.close()
                end
            else
                oil.open_float(vim.fn.getcwd())
            end
        end)
    end,
}
