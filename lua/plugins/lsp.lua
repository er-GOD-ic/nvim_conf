return {
	"neovim/nvim-lspconfig",
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- all clients
		vim.lsp.config("*", { capabilities = capabilities })

		vim.lsp.enable("lua_ls") -- lua
		vim.lsp.enable("nixd") -- nix
		vim.lsp.enable("rust-analyzer") -- rust
        vim.lsp.enable("jdtls") -- java
        vim.lsp.enable("clangd") -- c, cpp

		vim.diagnostic.config({
			virtual_text = true,
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

		-- 波線の設定
		vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#f38ba8" })
		vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#f9e2af" })
		vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#89dceb" })
		vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#94e2d5" })

		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, {})
	end,
}
