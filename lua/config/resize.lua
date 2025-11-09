local M = {}

local resize_step = 2
local exclude_ft = { "neo-tree" }

M.hasVerticalNeighbors = function()
    return vim.fn.winnr("k") ~= vim.fn.winnr() or vim.fn.winnr("j") ~= vim.fn.winnr()
end

M.hasHorizontalNeighbors = function()
    return vim.fn.winnr("h") ~= vim.fn.winnr() or vim.fn.winnr("l") ~= vim.fn.winnr()
end

---comment
---@param direction string Top=k Bottom=j Right=l Left=h
---@return boolean
M.isExcludeFt = function(direction)
    local filetype = vim.fn.getbufvar(vim.fn.winbufnr(vim.fn.winnr(direction)), "&filetype")
    for _, ft in ipairs(exclude_ft) do
        if filetype == ft then
            return true
        end
    end
    return false
end

---comment
---@param direction string Top=k, Bottom=j, Right=l, Left=h
---@return boolean
M.isEdgeWin = function(direction)
    return vim.fn.winnr() == vim.fn.winnr(direction)
end

M.ResizeLeft = function()
    if M.isEdgeWin("l") or M.isExcludeFt("l") then
        if not M.isEdgeWin("h") or not M.isExcludeFt("h") then
            vim.cmd("wincmd" .. resize_step .. ">")
        end
    else
        vim.cmd("wincmd" .. resize_step .. "<")
    end
end

M.ResizeRight = function()
    if M.isEdgeWin("l") or M.isExcludeFt("l") then
        if not M.isEdgeWin("h") or not M.isExcludeFt("h") then
            vim.cmd("wincmd" .. resize_step .. "<")
        end
    else
        vim.cmd("wincmd" .. resize_step .. ">")
    end
end

M.ResizeUp = function()
    -- if no vertically adjacent windows exist, do not resize.
    if not M.hasVerticalNeighbors() then
        return
    end

    if M.isEdgeWin("j") or M.isExcludeFt("j") then
        if not M.isEdgeWin("k") or not M.isExcludeFt("k") then
            vim.cmd("wincmd" .. resize_step .. "+")
        else
            vim.cmd("wincmd" .. resize_step .. "-")
        end
    else
        vim.cmd("wincmd" .. resize_step .. "-")
    end
end

M.ResizeDown = function()
    -- if no vertically adjacent windows exist, do not resize.
    if not M.hasVerticalNeighbors() then
        return
    end

    if M.isEdgeWin("j") or M.isExcludeFt("j") then
        if not M.isEdgeWin("k") or not M.isExcludeFt("k") then
            vim.cmd("wincmd" .. resize_step .. "-")
        else
            vim.cmd("wincmd" .. resize_step .. "+")
        end
    else
        vim.cmd("wincmd" .. resize_step .. "+")
    end
end

return M
