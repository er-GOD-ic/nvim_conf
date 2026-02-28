return {
	cmd = { "ts_ls" },
	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayCallSiteReturnTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
}
