return {
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
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

        -- lazyvimの情報を乗せるためのプレースホルダ
        dashboard.section.footer = {
            type = "text",
            val = {},
            opts = {
                position = "center",
                hl = "Comment",
            },
        }

        dashboard.section.buttons.val = {
            dashboard.button("e", "  New file", "<cmd>ene <CR>"),
            dashboard.button("f", "󰈞  Find file", "<cmd>Telescope find_files<CR>"),
            dashboard.button("h", "  Recently opened files", "<cmd>Telescope oldfiles<CR>"),
            dashboard.button("g", "󰈬  Find word", "<cmd>Telescope live_grep<CR>"),
            dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
        }

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
                local version = string.format(" v%d.%d.%d", vim.version().major, vim.version().minor, vim.version().patch)
                local plugins = string.format(" %d/%d plugins loaded in %.2fms", stats.loaded, stats.count, stats.startuptime)
                local footer = version .. "\t" .. plugins .. "\n"
                dashboard.section.footer.val = footer
                pcall(vim.cmd.AlphaRedraw)
            end,
        })
    end,
}
