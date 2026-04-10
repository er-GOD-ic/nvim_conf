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

  -- ビルド処理（Windowsでも安定）
  build = function()
    -- node確認
    if vim.fn.exepath("node") == "" then
      vim.notify("[markdown-preview.nvim] node が見つかりません", vim.log.levels.ERROR)
      return
    end

    -- npm or yarn 判定
    local installer = nil
    local args = nil

    if vim.fn.exepath("yarn") ~= "" then
      installer = vim.fn.exepath("yarn")
      args = { "install", "--production", "--frozen-lockfile" }
    elseif vim.fn.exepath("npm") ~= "" then
      installer = vim.fn.exepath("npm")
      args = { "ci", "--production", "--legacy-peer-deps" }
    else
      vim.notify("[markdown-preview.nvim] npm / yarn が見つかりません", vim.log.levels.ERROR)
      return
    end

    -- プラグインのパス
    local install_path = vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim/app"

    if vim.fn.isdirectory(install_path) == 0 then
      vim.notify("[markdown-preview.nvim] app ディレクトリが見つかりません", vim.log.levels.ERROR)
      return
    end

    -- 実行（shell非依存）
    local cmd = { installer }
    for _, v in ipairs(args) do
      table.insert(cmd, v)
    end

    local result = vim.fn.system(cmd, install_path)

    if vim.v.shell_error ~= 0 then
      vim.notify("[markdown-preview.nvim] install 失敗:\n" .. result, vim.log.levels.ERROR)
    else
      vim.notify("[markdown-preview.nvim] install 成功", vim.log.levels.INFO)
    end
  end,

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
