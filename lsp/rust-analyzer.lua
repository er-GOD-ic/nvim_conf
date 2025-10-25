return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	settings = {
		cargo = { allFeatures = true },
		checkOnSave = {
			command = "clippy",
		},
		diagnostics = {
			enable = true,
		},
	},
}
