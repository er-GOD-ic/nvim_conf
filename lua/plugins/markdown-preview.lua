return {
    "iamcco/markdown-preview.nvim",
    enabled = true,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
        local app = vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim/app"

        local cmd
        if vim.fn.exepath("yarn") ~= "" then
            cmd = { "yarn", "install" }
        elseif vim.fn.exepath("npm") ~= "" then
            if vim.uv.fs_stat(app .. "/package-lock.json") then
                cmd = { "npm", "ci" }
            else
                cmd = { "npm", "install" }
            end
        else
            vim.notify("yarn/npm が見つかりません", vim.log.levels.ERROR)
            return
        end

        local result = vim.system(cmd, { cwd = app }):wait()

        if result.code ~= 0 then
            vim.notify(result.stderr, vim.log.levels.ERROR)
        end
        vim.notify("build was successfully compleated.")
    end,
    config = function()
        vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<cr>")
    end,
}
