-- 前回の挿入モードのimeを記録
local last_insert_ime = "keyboard-us"
vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
        if last_insert_ime == "mozc\n" then
            vim.fn.system("fcitx5-remote -o")
        end
    end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        last_insert_ime = vim.fn.system("fcitx5-remote -n")
        vim.fn.system("fcitx5-remote -c")
    end,
})
