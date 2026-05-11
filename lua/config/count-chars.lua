local M = {}

M.config = {
    ft = { "markdown", "text" },
}

M.total_chars = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    local count = 0
    for _, line in ipairs(lines) do
        count = count + vim.fn.strchars(line)
    end

    return count
end

M.visual_chars = function()
    local start_pos = vim.fn.getpos("v")
    local end_pos = vim.fn.getpos(".")

    local start_line, start_col = start_pos[2], start_pos[3]
    local end_line, end_col = end_pos[2], end_pos[3]

    if start_line > end_line or (start_line == end_line and start_col > end_col) then
        start_line, end_line = end_line, start_line
        start_col, end_col = end_col, start_col
    end

    local count = 0
    for line_num = start_line, end_line do
        local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
        if line_num == start_line and line_num == end_line then
            count = count + vim.fn.strchars(line:sub(start_col, end_col))
        elseif line_num == start_line then
            count = count + vim.fn.strchars(line:sub(start_col))
        elseif line_num == end_line then
            count = count + vim.fn.strchars(line:sub(1, end_col))
        else
            count = count + vim.fn.strchars(line)
        end
    end

    return count
end

M.vline_chars = function()
    local start_pos = vim.fn.getpos("v")
    local end_pos = vim.fn.getpos(".")

    local start_line = start_pos[2]
    local end_line = end_pos[2]

    if start_line > end_line then
        start_line, end_line = end_line, start_line
    end

    local lines = vim.api.nvim_buf_get_lines(
        0,
        start_line - 1,
        end_line,
        false
    )

    local count = 0

    for _, line in ipairs(lines) do
        count = count + vim.fn.strchars(line)
    end

    return count
end

local function tableContains(tbl, str)
    for _, value in pairs(tbl) do
        if value == str then
            return true
        end
    end
    return false
end

M.char_count = function()
    if not tableContains(M.config.ft, vim.bo.filetype) then
        return ""
    end

    local total = M.total_chars()
    local visual = M.visual_chars()
    local vline = M.vline_chars()

    local mode = vim.fn.mode()

    if mode == "v" then
        return visual .. "/" .. total
    elseif mode == "V" then
        return vline .. "/" .. total
    else
        return total
    end
end

return M
