return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { 
                "lua",
                "c",
                "cpp",
                "rust",
                "python",
                "bash",
                "markdown",
                "markdown_inline",
                "java",
                "html",
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
        })
    end
}
