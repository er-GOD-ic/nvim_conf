local ns = vim.api.nvim_create_namespace("kanata_highlight")

vim.api.nvim_set_hl(0, "KanataAlias",      { fg = "#89b4fb", bold = true })
vim.api.nvim_set_hl(0, "KanataDisabled",   { fg = "#6c7087", italic = true })
vim.api.nvim_set_hl(0, "KanataTransparent",{ fg = "#7ec9d9" })
vim.api.nvim_set_hl(0, "KanataKeyword",    { fg = "#cba6f7", bold = true })
vim.api.nvim_set_hl(0, "KanataParamNum",   { fg = "#f9e2b0" })             -- tap-hold等の引数数値
vim.api.nvim_set_hl(0, "KanataKey",        { fg = "#cdd6f4" })             -- キーとしての数字・通常キー
vim.api.nvim_set_hl(0, "KanataModKey",     { fg = "#f38ba9" })

local mod_keys = {
  "lctrl", "rctrl", "lsft", "rsft",
  "lalt",  "ralt",  "lmet", "rmet",
  "lctl",  "rctl",
}

local keywords = {
  "defalias", "deflayer", "defsrc", "defcfg",
  "tap%-hold", "layer%-toggle", "layer%-switch",
  "one%-shot", "tap%-dance", "fork",
}

-- defsrc/deflayer ブロックの中にいるかを判定するステートマシン
-- 戦略: ( で深さを数え、deflayer/defsrc の ( を深さ1とみなす
local function build_layer_line_set(lines)
  local in_layer_lines = {}  -- row(0-indexed) -> true
  local depth = 0
  local in_layer = false
  local layer_depth = 0

  for lnum, line in ipairs(lines) do
    local row = lnum - 1

    -- defsrc / deflayer ブロック開始を検出
    if line:match("%(defsrc") or line:match("%(deflayer") then
      in_layer = true
      layer_depth = depth + (line:match("%(") and 1 or 0)
    end

    -- 括弧の深さを更新
    for ch in line:gmatch(".") do
      if ch == "(" then
        depth = depth + 1
      elseif ch == ")" then
        depth = depth - 1
        if in_layer and depth < layer_depth then
          in_layer = false
        end
      end
    end

    if in_layer then
      in_layer_lines[row] = true
    end
  end

  return in_layer_lines
end

local function apply_highlights(bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local layer_lines = build_layer_line_set(lines)

  for lnum, line in ipairs(lines) do
    local row = lnum - 1
    local is_layer = layer_lines[row]

    -- @alias 呼び出し
    for col_s, col_e in line:gmatch("()@[%w_%-]+()") do
      vim.api.nvim_buf_set_extmark(bufnr, ns, row, col_s - 1, {
        end_col = col_e - 1,
        hl_group = "KanataAlias",
      })
    end

    -- XX（無効キー）
    for col_s, col_e in line:gmatch("()%f[%w_]XX%f[^%w_]()") do
      vim.api.nvim_buf_set_extmark(bufnr, ns, row, col_s - 1, {
        end_col = col_e - 1,
        hl_group = "KanataDisabled",
      })
    end

    -- _（透過キー）
    for col_s, col_e in line:gmatch("()%f[%w_]_%f[^%w_]()") do
      vim.api.nvim_buf_set_extmark(bufnr, ns, row, col_s - 1, {
        end_col = col_e - 1,
        hl_group = "KanataTransparent",
      })
    end

    -- キーワード
    for _, kw in ipairs(keywords) do
      for col_s, col_e in line:gmatch("()" .. kw .. "()") do
        vim.api.nvim_buf_set_extmark(bufnr, ns, row, col_s - 1, {
          end_col = col_e - 1,
          hl_group = "KanataKeyword",
        })
      end
    end

    -- 修飾キー名
    for _, mk in ipairs(mod_keys) do
      for col_s, col_e in line:gmatch("()%f[%w_]" .. mk .. "%f[^%w_]()") do
        vim.api.nvim_buf_set_extmark(bufnr, ns, row, col_s - 1, {
          end_col = col_e - 1,
          hl_group = "KanataModKey",
        })
      end
    end

    -- 数値の分岐
    for col_s, col_e in line:gmatch("()%f[%d]%d+%f[^%d]()") do
      local hl = is_layer and "KanataKey" or "KanataParamNum"
      vim.api.nvim_buf_set_extmark(bufnr, ns, row, col_s - 1, {
        end_col = col_e - 1,
        hl_group = hl,
      })
    end
  end
end

vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI" }, {
  pattern = "kanata.nix",
  callback = function(ev)
    apply_highlights(ev.buf)
  end,
})
