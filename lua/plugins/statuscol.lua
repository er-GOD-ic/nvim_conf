return {
    "luukvbaal/statuscol.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- 依存関係を明示
    event = "BufReadPre",
    enabled = true,
    config = function()
        local bit = require("bit")
        local devicons = require("nvim-web-devicons")

        -- 権限ビットを文字列（rwxrwxrwx）に変換する関数
        local function perm_to_string(mode)
            local function triad(val)
                local r = bit.band(val, 4) ~= 0 and "r" or "-"
                local w = bit.band(val, 2) ~= 0 and "w" or "-"
                local x = bit.band(val, 1) ~= 0 and "x" or "-"
                return r .. w .. x
            end

            local perms = bit.band(mode, 0x1FF)
            local owner = bit.rshift(perms, 6)
            local group = bit.rshift(perms, 3) % 8
            local other = perms % 8

            return triad(owner) .. triad(group) .. triad(other)
        end

        local is_oil_buffer = function()
            return vim.bo.filetype == "oil"
        end

        require("statuscol").setup({
            setopt = true,
            relculright = false,
            segments = {
                { text = { "%s" }, click = "v:lua.ScSa" }, -- sign
                { text = { "%l" }, click = "v:lua.ScLa" }, -- line number
                {
                    text = { " " },
                    condition = {
                        function()
                            return is_oil_buffer()
                        end,
                    },
                    hl = "NonText",
                },
                {
                    text = {
                        " ",
                        function(args)
                            if not is_oil_buffer() then
                                return ""
                            end
                            local oil = require("oil")
                            local entry = oil.get_entry_on_line(args.buf, args.lnum)

                            if entry and entry.name then
                                local dir = oil.get_current_dir(args.buf)
                                if dir then
                                    local full_path = dir .. entry.name
                                    local uv = vim.uv or vim.loop
                                    local stat = uv.fs_stat(full_path)

                                    if stat and stat.mode then
                                        -- 次のセグメント（パーミッション）がアイコンの色に引きずられないよう、
                                        -- 明示的に「%#NonText#」を先頭に付与してリセット＆上書きします
                                        return "%#NonText#" .. perm_to_string(stat.mode)
                                    end
                                end
                            end
                            return "%#NonText#---------"
                        end,
                    },
                    { text = { " " } }, -- padding
                },
                {
                    text = {
                        " ",
                        function(args)
                            if not is_oil_buffer() then
                                return ""
                            end
                            local oil = require("oil")
                            local entry = oil.get_entry_on_line(args.buf, args.lnum)

                            if entry and entry.name then
                                local icon, hl_group
                                if entry.type == "directory" then
                                    icon = "󰉋"
                                    hl_group = "Directory"
                                else
                                    local ext = vim.fn.fnamemodify(entry.name, ":e")
                                    icon, hl_group = devicons.get_icon(entry.name, ext, { default = true })
                                end

                                -- フォールバック用のハイライト
                                hl_group = hl_group or "Normal"

                                -- 「%#ハイライトグループ名#アイコン 」の形式で返す
                                return "%#" .. hl_group .. "#" .. icon .. " "
                            end
                            return "%#" .. "NonText" .. "#" .. "" .. " "
                        end,
                    },
                    condition = {
                        function()
                            return vim.bo.filetype == "oil"
                        end,
                    },
                    hl = "Normal",
                },
            },
        })
    end,
}
