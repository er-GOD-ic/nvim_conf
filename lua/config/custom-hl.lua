local M = {}

local function setup_hml_signs()
  if M._hml_signs_defined then
    return
  end

  -- ハイライトグループ（好みで色を変更してください）
  vim.api.nvim_command('highlight HmlNumHL_H guifg=#6c7086 gui=bold')
  vim.api.nvim_command('highlight HmlNumHL_M guifg=#6c7086 gui=bold')
  vim.api.nvim_command('highlight HmlNumHL_L guifg=#6c7086 gui=bold')

  -- サイン定義（テキストは空白にしてサイン列を汚さない）
  vim.fn.sign_define('HmlSignH', { text = ' ', texthl = '', numhl = 'HmlNumHL_H' })
  vim.fn.sign_define('HmlSignM', { text = ' ', texthl = '', numhl = 'HmlNumHL_M' })
  vim.fn.sign_define('HmlSignL', { text = ' ', texthl = '', numhl = 'HmlNumHL_L' })

  M._hml_signs_defined = true
end

-- bufnr: number (optional, defaults to current buffer)
-- h_line/m_line/l_line: line numbers (1-based)
M.place_hml_signs = function(bufnr, h_line, m_line, l_line)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  setup_hml_signs()

  -- まず前回のマークを消す（このグループ内のそのバッファのサインをすべて削除）
  pcall(vim.fn.sign_unplace, 'hml_marks', { buffer = bufnr })

  local max = vim.api.nvim_buf_line_count(bufnr)
  local function place(id_offset, name, lnum)
    if not lnum or lnum < 1 or lnum > max then
      return
    end
    -- 一意の id を生成（バッファごとに衝突しないように）
    local id = bufnr * 100 + id_offset
    pcall(vim.fn.sign_place, id, 'hml_marks', name, bufnr, { lnum = lnum })
  end

  place(1, 'HmlSignH', h_line)
  place(2, 'HmlSignM', m_line)
  place(3, 'HmlSignL', l_line)
end

M.hml_lines = function()
  -- 既存のロジックに合わせて H/M/L を算出
  local h_line = vim.fn.line("w0") == 1 and 1 or vim.fn.line("w0") + vim.o.scrolloff
  local l_line = vim.fn.line("w$") == vim.fn.line("$") and vim.fn.line("$") or vim.fn.line("w$") - vim.o.scrolloff
  local m_line = math.floor((vim.fn.line("w0") + vim.fn.line("w$")) / 2)

  -- サイン配置（現在のバッファに対して）
  local bufnr = vim.api.nvim_get_current_buf()
  M.place_hml_signs(bufnr, h_line, m_line, l_line)

  -- デバッグ出力が欲しい場合は以下を有効にしてください（常時表示は邪魔になるのでデフォルトはオフ）。
  -- print(string.format("scrolloff: %d  H: %d  M: %d  L: %d", vim.o.scrolloff, h_line, m_line, l_line))
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinScrolled", "CursorMoved", "CursorMovedI" }, {
  pattern = { "*.lua" },
  callback = M.hml_lines,
})

return M
