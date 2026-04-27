local M = {}

local function get_hl_fg(name, fallback)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  if ok and hl and hl.fg then
    return string.format("#%06x", hl.fg)
  end
  return fallback
end

local function setup_hml_signs()
  if M._hml_signs_defined then return end

  -- colorschemeに依存する色を取得
  local color_h = get_hl_fg("DiagnosticHint", "#00aaff")
  local color_m = get_hl_fg("DiagnosticHint", "#00aaff")
  local color_l = get_hl_fg("DiagnosticHint", "#00aaff")

  -- highlight定義（API推奨）
  vim.api.nvim_set_hl(0, "HmlNumHL_H", { fg = color_h, bold = true, default = true })
  vim.api.nvim_set_hl(0, "HmlNumHL_M", { fg = color_m, bold = true, default = true })
  vim.api.nvim_set_hl(0, "HmlNumHL_L", { fg = color_l, bold = true, default = true })

  -- サイン定義
  vim.fn.sign_define("HmlSignH", { text = " ", texthl = "", numhl = "HmlNumHL_H" })
  vim.fn.sign_define("HmlSignM", { text = " ", texthl = "", numhl = "HmlNumHL_M" })
  vim.fn.sign_define("HmlSignL", { text = " ", texthl = "", numhl = "HmlNumHL_L" })

  M._hml_signs_defined = true
end

-- bufnr: number (optional, defaults to current buffer)
-- h_line/m_line/l_line: line numbers (1-based)
M.place_hml_signs = function(bufnr, lines)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    setup_hml_signs()

    -- まず前回のマークを消す（このグループ内のそのバッファのサインをすべて削除）
    pcall(vim.fn.sign_unplace, "hml_marks", { buffer = bufnr })

    local max = vim.api.nvim_buf_line_count(bufnr)
    local function place(id_offset, name, lnum)
        if not lnum or lnum < 1 or lnum > max then
            return
        end
        -- 一意の id を生成（バッファごとに衝突しないように）
        local id = bufnr * 100 + id_offset
        pcall(vim.fn.sign_place, id, "hml_marks", name, bufnr, { lnum = lnum })
    end

    place(1, "HmlSignH", lines.h)
    place(2, "HmlSignM", lines.m)
    place(3, "HmlSignL", lines.l)
end

M.hml_lines = function()
    -- 既存のロジックに合わせて H/M/L を算出
    local h_line = vim.fn.line("w0") == 1 and 1 or vim.fn.line("w0") + vim.o.scrolloff
    local m_line = math.floor((vim.fn.line("w0") + vim.fn.line("w$")) / 2)
    local l_line = vim.fn.line("w$") == vim.fn.line("$") and vim.fn.line("$") or vim.fn.line("w$") - vim.o.scrolloff

    return {
        h = h_line,
        m = m_line,
        l = l_line,
    }
end

M.update = function()
    -- サイン配置
    local bufnr = vim.api.nvim_get_current_buf()
    M.place_hml_signs(bufnr, M.hml_lines())
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinScrolled", "CursorMoved", "CursorMovedI" }, {
    pattern = { "*.*" },
    callback = M.update,
})

local ns = vim.api.nvim_create_namespace("hml_watch")

vim.api.nvim_set_decoration_provider(ns, {
    on_win = function(_, winid, bufnr, topline, botline)
        -- 表示範囲が変わったときだけ処理したいならキャッシュする
        local key = winid
        local prev = vim.w._hml_view

        if not prev or prev.top ~= topline or prev.bot ~= botline then
            vim.w._hml_view = { top = topline, bot = botline }

            -- 重くしないため schedule 推奨
            vim.schedule(function()
                M.update()
            end)
        end
    end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    M._hml_signs_defined = false
    setup_hml_signs()
  end,
})

return M
