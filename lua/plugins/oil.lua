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
                ["g/"] = { "actions.toggle_trash", mode = "n" },
                ["q"] = { "actions.close", mode = "n" },
            },
        })

        local function is_oil_buffer()
            return vim.bo.filetype == "oil"
        end
        local function is_trash_buffer()
            return vim.api.nvim_buf_get_name(0):match("^oil%-trash")
        end

        local function close_oil_buffers()
            if is_oil_buffer() then
                oil.close()
                if is_trash_buffer() then
                    oil.close()
                end
                return
            end
            if is_trash_buffer() then
                oil.close()
            end
        end

        local function close_oil_windows()
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)

                if vim.bo[buf].filetype == "oil" then
                    vim.api.nvim_win_close(win, true)
                end
            end
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "TelescopePrompt",
            callback = close_oil_windows,
        })

        -- keymaps
        vim.keymap.set("n", "<leader>e", function()
            if is_oil_buffer() and not is_trash_buffer() then
                close_oil_buffers()
            else
                oil.open_float(vim.fn.getcwd())
            end
        end)

        vim.api.nvim_create_autocmd("bufenter", {
            pattern = "TelescopePrompt",
            callback = close_oil_windows,
        })
    end,
}
