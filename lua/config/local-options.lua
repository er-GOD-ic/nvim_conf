-- cursorline
local disable_cul_filetypes = {
    "toggleterm",
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = disable_cul_filetypes,
    callback = function()
        vim.opt_local.cursorline = false
    end,
})

-- cursorcolumn
local disable_cuc_filetypes = {
    "neo-tree",
    "toggleterm",
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = disable_cuc_filetypes,
    callback = function()
        vim.wo.cursorcolumn = false
        vim.opt_local.cursorcolumn = false
    end,
})

-- disable cul on neo-tree
-- neotree could not simply set local_option in autocmd
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local ft = vim.bo.filetype
        if ft == "neo-tree" then
            vim.opt_local.cursorcolumn = false
        end
    end,
})
