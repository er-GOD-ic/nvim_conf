local is_windows = vim.fn.has("win32") == 1

return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1001, -- 最優先で読み込む
    enabled = not is_windows,
    opts = {
      rocks = { "magick" },
    },
  },
  {
    "3rd/image.nvim",
    dependencies = { "luarocks.nvim" },
    event = "VeryLazy",
    enabled = not is_windows,
    config = function()
      require("image").setup({
        backend = "ueberzug",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki" },
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
      })
    end,
  },
}
