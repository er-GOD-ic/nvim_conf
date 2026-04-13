 return {
  "iamcco/markdown-preview.nvim",

  -- Markdownファイルのときだけ読み込む
  ft = { "markdown" },

  -- コマンドでも起動可能
  cmd = {
    "MarkdownPreviewToggle",
    "MarkdownPreview",
    "MarkdownPreviewStop",
  },

  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,

  -- ビルド処理
  build = "cd app & npm install",

  -- 設定
  init = function()
    -- 自動起動しない
    vim.g.mkdp_auto_start = 0

    -- バッファ閉じたら停止
    vim.g.mkdp_auto_close = 1

    -- 更新タイミング
    vim.g.mkdp_refresh_slow = 0

    -- ブラウザ指定（Windows）
    vim.g.mkdp_browser = "C:\\Program Files\\Mozilla Firefox\\firefox.exe"

    -- プレビューURL
    vim.g.mkdp_open_to_the_world = 0

    -- ポート固定（必要なら）
    -- vim.g.mkdp_port = 8080
  end,
}
