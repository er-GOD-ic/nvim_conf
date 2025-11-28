return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			transparent_background = false,
			custom_highlights = function(colors)
				return {
                    CursorLineNr = { bg = "#2a2b3d" },
					CursorColumn = { bg = "#2a2b3d" },
				}
			end,
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
