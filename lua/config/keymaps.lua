-- save
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { noremap = true, silent = true, desc = "save current buffer" })
vim.keymap.set("n", "<leader>W", "<cmd>wa<cr>", { noremap = true, silent = true, desc = "save all buffers" })
-- quit
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { noremap = true, silent = true, desc = "close current buffer" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa<cr>", { noremap = true, silent = true, desc = "quit neovim" })
vim.keymap.set("n", "<leader>x", "<cmd>x<cr>", { noremap = true, silent = true, desc = "save and close current buffer" })
vim.keymap.set("n", "<leader>X", "<cmd>xa<cr>", { noremap = true, silent = true, desc = "save and quit neovim" })

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

local resize = require("config.resize")
vim.keymap.set("n", "<A-h>", resize.ResizeLeft, { noremap = true, silent = true })
vim.keymap.set("n", "<A-j>", resize.ResizeDown, { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", resize.ResizeUp, { noremap = true, silent = true })
vim.keymap.set("n", "<A-l>", resize.ResizeRight, { noremap = true, silent = true })

-- clear search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch\n", { noremap = true, silent = true, desc = "clear search" })

-- terminal
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true, desc = "toggle terminal" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "escape terminal" })
