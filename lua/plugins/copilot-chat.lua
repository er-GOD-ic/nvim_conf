return {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        { "zbirenbaum/copilot.lua" },
        { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    opts = {
        model = "gpt-5-mini",
        temperature = 0.1,
        system_prompt = "必ず日本語で簡潔に回答してください。",
        window = {
            layout = "float",
            width = 0.8,
            height = 0.8,
            border = "rounded",
        },
    },
    config = function(_, opts)
        require("CopilotChat").setup(opts)

        -- keymap
        vim.keymap.set("n", "<leader><Tab>", "<cmd>CopilotChatToggle<cr>", { desc = "CopilotChat - Toggle" })
    end,
}
