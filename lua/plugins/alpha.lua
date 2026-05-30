return {
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        local function is_in_config_dir()
            return vim.fs.normalize(vim.fn.getcwd()) == vim.fs.normalize(vim.fn.stdpath("config"))
        end
        local function is_original_pwd()
            return vim.fs.normalize(vim.g.original_pwd) == vim.fs.normalize(vim.fn.getcwd())
        end

        local config_header = {
            [[                                               ]],
            [[                                               ]],
            [[                                               ]],
            [[                                               ]],
            [[                                               ]],
            [[                                               ]],
            [[ ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ ]],
            [[██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ ]],
            [[██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗]],
            [[██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║]],
            [[╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝]],
            [[ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ ]],
            [[                                               ]],
            [[                                               ]],
            [[                                               ]],
        }
        local default_header = {
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                     ]],
            [[       ████ ██████           █████      ██                     ]],
            [[      ███████████             █████                             ]],
            [[      █████████ ███████████████████ ███   ███████████   ]],
            [[     █████████  ███    █████████████ █████ ██████████████   ]],
            [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
            [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
            [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
        }

        local build_buttons

        local open_config, exit_config
        open_config = function()
            vim.cmd("cd " .. vim.fn.stdpath("config"))
            print("Opening configuration directory: " .. vim.fn.getcwd())
            dashboard.section.header.val = config_header
            dashboard.section.buttons.val = build_buttons(true)
            vim.cmd("AlphaRemap")
            vim.cmd("AlphaRedraw")
        end
        exit_config = function()
            vim.cmd("cd " .. vim.g.original_pwd)
            print("Exiting configuration directory, returning to: " .. vim.fn.getcwd())
            dashboard.section.header.val = default_header
            dashboard.section.buttons.val = build_buttons(false)
            vim.cmd("AlphaRemap")
            vim.cmd("AlphaRedraw")
        end

        build_buttons = function(in_config)
            local buttons = {
                dashboard.button("e", "󰣞  Open Oil", function()
                    require("oil").toggle_float(vim.fn.getcwd())
                end),
                dashboard.button("f", "󰈞  Find file", "<cmd>Telescope find_files<CR>"),
                dashboard.button("g", "󰈬  Find word", "<cmd>Telescope live_grep<CR>"),
            }

            if in_config then
                if not is_original_pwd() then
                    table.insert(buttons, dashboard.button("c", "  Exit Configuration", exit_config))
                end
            else
                table.insert(buttons, dashboard.button("c", "  Configuration", open_config))
            end

            table.insert(buttons, dashboard.button("q", "  Quit", "<cmd>qa<CR>"))

            return buttons
        end

        if is_in_config_dir() then
            dashboard.section.header.val = config_header
        else
            dashboard.section.header.val = default_header
        end

        -- lazyvimの情報を乗せるためのプレースホルダ
        dashboard.section.footer = {
            type = "text",
            val = {},
            opts = {
                position = "center",
                hl = "Comment",
            },
        }

        dashboard.section.buttons.val = build_buttons(is_in_config_dir())

        dashboard.config.layout = {
            { type = "padding", val = 5 },
            dashboard.section.header,
            { type = "padding", val = 5 },
            dashboard.section.buttons,
            { type = "padding", val = 1 },
            dashboard.section.footer,
        }

        alpha.setup(dashboard.config)

        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            callback = function()
                local stats = require("lazy").stats()
                local version =
                    string.format(" v%d.%d.%d", vim.version().major, vim.version().minor, vim.version().patch)
                local plugins =
                    string.format(" %d/%d plugins loaded in %.2fms", stats.loaded, stats.count, stats.startuptime)
                local footer = version .. "\t" .. plugins .. "\n"
                dashboard.section.footer.val = footer
                pcall(vim.cmd.AlphaRedraw)
            end,
        })
    end,
}
