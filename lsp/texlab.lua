return {
    cmd = { "texlab" },
    filetypes = { "tex" },

    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
    end,

    settings = {
        texlab = {
            build = {
                executable = "latexmk",
                args = {
                    "-pdf",
                    "-interaction=nonstopmode",
                    "-synctex=1",
                    "%f",
                },
                onSave = true,
            },
            forwardSearch = {
                executable = "zathura",
                args = { "--synctex-forward", "%l:1:%f", "%p" },
            },
        },
    },
}
