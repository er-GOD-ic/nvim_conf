return {
  "neovim/nvim-lspconfig",
  ft = { "java" },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- mason で jdtls をインストールしたパスを取得
    local mason_registry = require("mason-registry")
    local jdtls_pkg = mason_registry.get_package("jdtls")
    local jdtls_path = jdtls_pkg:get_install_path()

    -- OSごとに設定を切り替える (jdtlsはOS依存のランチャーを持っている)
    local system = vim.loop.os_uname().sysname
    local config_os = "linux"
    if system:find("Windows") then
      config_os = "win"
    elseif system:find("Darwin") then
      config_os = "mac"
    end

    -- プロジェクトごとのワークスペースディレクトリ
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

    -- jdtls の起動設定
    local cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xms1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens", "java.base/java.util=ALL-UNNAMED",
      "--add-opens", "java.base/java.lang=ALL-UNNAMED",
      "-jar", jdtls_path .. "/plugins/org.eclipse.equinox.launcher.jar",
      "-configuration", jdtls_path .. "/config_" .. config_os,
      "-data", workspace_dir,
    }

    -- lspconfig で jdtls を起動
    lspconfig.jdtls.setup({
      cmd = cmd,
      capabilities = capabilities,
      root_dir = lspconfig.util.root_pattern(".git", "mvnw", "gradlew", "pom.xml", "build.gradle"),
    })
  end,
}
