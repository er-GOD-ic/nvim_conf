return {
    "lervag/vimtex",
    ft = "tex",
    init = function()
        vim.g.vimtex_version_check = false
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_compiler_latexmk_engines = {
            _ = "-lualatex",
        }

        vim.g.vimtex_compiler_latexmk = {
            executable = "latexmk",
            options = {
                "-lualatex",
                "-interaction=nonstopmode",
                "-synctex=1",
            },
        }
    end,
}
