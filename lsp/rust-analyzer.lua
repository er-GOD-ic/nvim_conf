return {
    cmd = { "rust-analyzer" },
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
