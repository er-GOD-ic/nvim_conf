-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- number
vim.opt.relativenumber = true
vim.opt.number = true
-- wrap
vim.o.wrap = false
-- scrolloff
vim.o.scrolloff = 8
vim.o.sidescrolloff = 15
-- indent
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- clipboard
vim.opt.clipboard = "unnamedplus"

-- encoding
vim.opt.encoding = 'utf-8'
vim.opt.fileencodings = { "utf-8", "cp932", "euc-jp", "iso-2022-jp", "latin1" }

-- plugin manager
require("config.lazy")
