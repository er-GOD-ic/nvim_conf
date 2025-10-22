return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("nixd")
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
		vim.lsp.config("nixd", {})

		vim.diagnostic.config({
			virtual_text = false,
			signs = {
				enable = true,
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, {})
	end,
}
