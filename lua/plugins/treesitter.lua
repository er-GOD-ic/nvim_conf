return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/playground",
    },
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua",
                "nix",
                "scheme",
                "c",
                "cpp",
                "rust",
                "python",
                "bash",
                "markdown",
                "markdown_inline",
                "java",
                "html",
                "typescript",
                "tsx",
                "javascript",
                "php",
                "toml",
                "gitignore",
                "json",
                "hjson",
            },
            sync_install = true,
            auto_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            playground = { enable = true }
        })
    end,
}
