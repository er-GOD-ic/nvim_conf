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

        dashboard.section.buttons.val = {
            dashboard.button("e", "  New file", "<cmd>ene <CR>"),
            dashboard.button("f", "󰈞  Find file", "<cmd>Telescope find_files<CR>"),
            dashboard.button("h", "  Recently opened files", "<cmd>Telescope oldfiles<CR>"),
            dashboard.button("g", "󰈬  Find word", "<cmd>Telescope live_grep<CR>"),
            dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
        }

        -- Lazy.nvim の読み込みステータス
        local lazy_stats = require("lazy").stats()
        local loaded_plugins = lazy_stats.loaded
        local total_plugins = lazy_stats.count
        local startup_ms = math.floor(lazy_stats.startuptime * 100 + 0.5) / 100

        dashboard.section.lazy_info = {
            type = "text",
            val = string.format("⚡️ %d/%d plugins loaded in %.2fms", loaded_plugins, total_plugins, startup_ms),
            opts = {
                position = "center",
                hl = "Comment", -- グレーっぽい色で表示
            },
        }

        dashboard.config.layout = {
            { type = "padding", val = 5 },
            dashboard.section.header,
            { type = "padding", val = 5 },
            dashboard.section.buttons,
            { type = "padding", val = 1 },
            dashboard.section.lazy_info,
        }

        alpha.setup(dashboard.config)
    end,
}
