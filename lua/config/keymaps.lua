-- save/quit
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { noremap = true, silent = true, desc = "save current buffer" })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { noremap = true, silent = true, desc = "close current buffer" })
vim.keymap.set("n", "<leader><leader>w", "<cmd>wa<cr>", { noremap = true, silent = true, desc = "save all buffers" })
vim.keymap.set("n", "<leader><leader>q", "<cmd>qa<cr>", { noremap = true, silent = true, desc = "quit neovim" })
vim.keymap.set("n", "<leader>!", function()
    local choice = vim.fn.confirm("Really quit Neovim?", "&Yes\n&No", 2)
    if choice == 1 then
        vim.cmd("qa!")
    end
end, { desc = "Force quit Neovim" })

-- clear search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch\n", { noremap = true, silent = true, desc = "clear search" })

-- escape terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "escape terminal" })

-- tab char
vim.keymap.set("i", "<S-Tab>", "<C-v><Tab>")

-- copy path
vim.keymap.set("n", "<leader>yp", function()
    local path = vim.api.nvim_buf_get_name(0)
    if path == "" then
        print("No file path to copy")
        return
    end
    vim.fn.setreg("+", path)
    print("Copied file path: " .. path)
end, { noremap = true, silent = true, desc = "copy current file path" })
