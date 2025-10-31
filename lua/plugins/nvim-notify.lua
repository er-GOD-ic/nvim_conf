return {
    "rcarriga/nvim-notify",
    config = function()
		require("notify").setup({
			render = "compact",
			stages = "fade_in_slide_out",
            top_down = false,
			timeout = 5000,
		})
	end,
}
