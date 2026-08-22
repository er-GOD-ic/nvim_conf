vim.g.original_pwd = vim.fn.getcwd()

require("config.options")       -- editor global options
require("config.keymaps")       -- general keymaps
require("config.count-chars")
require("config.lazy")          -- plugin manager
