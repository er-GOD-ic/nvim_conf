-- save
vim.keymap.set("n", "<leader>w", ":w\n", { noremap = true, silent = true, desc = "save current buffer" })
vim.keymap.set("n", "<leader>W", ":wa\n", { noremap = true, silent = true, desc = "save all buffers" })
-- quit
vim.keymap.set("n", "<leader>q", ":q\n", { noremap = true, silent = true, desc = "close current buffer" })
vim.keymap.set("n", "<leader>Q", ":qa\n", { noremap = true, silent = true, desc = "quit neovim" })
vim.keymap.set("n", "<leader>x", ":x\n", { noremap = true, silent = true, desc = "save and close current buffer" })
vim.keymap.set("n", "<leader>X", ":xa\n", { noremap = true, silent = true, desc = "save and quit neovim" })

-- move focus
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- clear search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch\n", { noremap = true, silent = true })
