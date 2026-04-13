return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    -- プラグインを読み込む（opt の場合に必要）
    pcall(vim.cmd, "packadd markdown-preview.nvim")

    -- node があるか
    if vim.fn.exepath("node") == "" then
      print("[markdown-preview.nvim] node が PATH にありません。node を入れてください。")
      return
    end

    -- yarn があるなら yarn、なければ npm を使う
    local installer_cmd
    local app_dir = vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim/app"
    local lockfile = app_dir .. "/package-lock.json"

    if vim.fn.exepath("yarn") ~= "" then
      installer_cmd = "yarn install"

    elseif vim.fn.exepath("npm") ~= "" then
      -- package-lock.json の存在チェック
      if vim.loop.fs_stat(lockfile) then
        installer_cmd = "npm ci"
      else
        installer_cmd = "npm install"
      end

    else
      print("[markdown-preview.nvim] yarn/npm が見つかりません。")
      return
    end

    -- プラグインの app ディレクトリでインストール（lazy の置き場所に依存）
    local data = vim.fn.stdpath("data")
    local candidates = {
      data .. "/lazy/markdown-preview.nvim/app",
      data .. "/lazy/markdown-preview.nvim",
    }
    local target = nil
    for _, p in ipairs(candidates) do
      if vim.fn.isdirectory(p) == 1 then
        target = p
        break
      end
    end
    if not target then
      print("[markdown-preview.nvim] プラグインディレクトリが見つかりません: " .. data .. "/lazy/markdown-preview.nvim")
      return
    end

    local cmd = "cd " .. vim.fn.shellescape(target) .. " && " .. installer_cmd
    local out = vim.fn.system(cmd)
    if vim.v.shell_error ~= 0 then
      print("[markdown-preview.nvim] install に失敗しました: " .. out)
    else
      print("[markdown-preview.nvim] install 成功: " .. out)
    end
  end,
}
