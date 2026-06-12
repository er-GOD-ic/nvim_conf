-- reload config
vim.keymap.set('n', '<leader>rs', ':luafile $MYVIMRC<CR>', { desc = "Reload Config" })
-- save
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { noremap = true, silent = true, desc = "save current buffer" })
vim.keymap.set("n", "<leader>W", "<cmd>wa<cr>", { noremap = true, silent = true, desc = "save all buffers" })
-- quit
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { noremap = true, silent = true, desc = "close current buffer" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa<cr>", { noremap = true, silent = true, desc = "quit neovim" })

-- clear search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch\n", { noremap = true, silent = true, desc = "clear search" })

-- move focus
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- split window
vim.keymap.set("n", "<leader><C-h>", "<cmd>vsplit<CR> <C-w>h <cmd>enew<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><C-j>", "<cmd>split<CR>  <C-w>j <cmd>enew<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><C-k>", "<cmd>split<CR>  <C-w>k <cmd>enew<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><C-l>", "<cmd>vsplit<CR> <C-w>l <cmd>enew<CR>", { noremap = true, silent = true })

-- resize window
local resize = require("config.resize")
vim.keymap.set("n", "<A-h>", resize.ResizeLeft, { noremap = true, silent = true })
vim.keymap.set("n", "<A-j>", resize.ResizeDown, { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", resize.ResizeUp, { noremap = true, silent = true })
vim.keymap.set("n", "<A-l>", resize.ResizeRight, { noremap = true, silent = true })

-- terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "escape terminal" })

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

-- markdown
-- bold
vim.keymap.set("n", "<leader>mb", "diwi**<esc>pa**<esc>")
vim.keymap.set("v", "<leader>mb", "di**<esc>pa**<esc>")
-- underline
vim.keymap.set("n", "<leader>mu", "diwi<u><esc>pa</u><esc>")
vim.keymap.set("v", "<leader>mu", "di<u><esc>pa</u><esc>")
-- math block
vim.keymap.set("n", "<leader>mm", "diwi$<esc>pa$<esc>")
vim.keymap.set("v", "<leader>mm", "di$<esc>pa$<esc>")
-- force break

-- toggle binary / hex
vim.keymap.set("n", "<leader>b", function()
    if vim.b.editHex then
        vim.cmd("%!xxd -r")
        vim.b.editHex = nil
    else
        vim.cmd("%!xxd")
        vim.b.editHex = true
    end
end)
