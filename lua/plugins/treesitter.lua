local is_nixos = vim.loop.os_uname().sysname == "Linux"
    and vim.fn.isdirectory("/nix/store") == 1

return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/playground",
    },
    enabled = false,
    branch = "main",
    lazy = false,

    build = is_nixos and nil or ":TSUpdate",

    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = is_nixos and {} or {
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

            sync_install = false,
            auto_install = not is_nixos,

            highlight = {
                enable = true,
            },

            indent = {
                enable = true,
            },

            playground = {
                enable = true,
            },
        })
    end,
}
