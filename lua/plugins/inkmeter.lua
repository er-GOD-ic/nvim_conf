return {
    dir = "/home/ergodic/.config/nvim-plugins/inkmeter.nvim/",
    config = function()
        require("inkmeter").setup({})
        vim.keymap.set('n', '<leader>cc', ':lua print(require("inkmeter").count())<cr>')
    end
}
