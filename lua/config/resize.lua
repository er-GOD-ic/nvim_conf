local M = {}

local resize_step = 2

M.hasVerticalNeighbors = function()
    return vim.fn.winnr("k") ~= vim.fn.winnr() and vim.fn.winnr("j") ~= vim.fn.winnr()
end

M.hasHorizontalNeighbors = function()
    return vim.fn.winnr("h") ~= vim.fn.winnr() and vim.fn.winnr("l") ~= vim.fn.winnr()
end

M.isRightMost = function()
    return vim.fn.winnr() == vim.fn.winnr("l")
end

M.isLeftMost = function()
    return vim.fn.winnr() == vim.fn.winnr("h")
end

M.isBottomMost = function()
    return vim.fn.winnr() == vim.fn.winnr("j")
end

M.isTopMost = function()
    return vim.fn.winnr() == vim.fn.winnr("k")
end

M.ResizeLeft = function()
    if M.isRightMost() then
        if not M.isLeftMost() then
            vim.cmd("wincmd" .. resize_step .. ">")
        end
    else
        vim.cmd("wincmd" .. resize_step .. "<")
    end
end

M.ResizeRight = function()
    if M.isRightMost() then
        if not M.isLeftMost() then
            vim.cmd("wincmd" .. resize_step .. "<")
        end
    else
        vim.cmd("wincmd" .. resize_step .. ">")
    end
end

M.ResizeUp = function()
    if M.isBottomMost() then
        if not M.isTopMost() then
            vim.cmd("wincmd" .. resize_step .. "+")
        else
            if M.hasVerticalNeighbors() then
                vim.cmd("wincmd" .. resize_step .. "-")
            end
        end
    else
        vim.cmd("wincmd" .. resize_step .. "-")
    end
end

M.ResizeDown = function()
    if M.isBottomMost() then
        if not M.isTopMost() then
            vim.cmd("wincmd" .. resize_step .. "-")
        else
            vim.cmd("wincmd" .. resize_step .. "+")
        end
    else
        vim.cmd("wincmd" .. resize_step .. "+")
    end
end

return M
