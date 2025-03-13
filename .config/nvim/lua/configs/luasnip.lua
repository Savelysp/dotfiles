local ls = require("luasnip")
local fs_vs = require("luasnip.loaders.from_vscode")
local fs_sm = require("luasnip.loaders.from_snipmate")
local fs_lua = require("luasnip.loaders.from_lua")

-- Настройка luasnip
ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    -- enable_autosnippets = true,
})

-- vscode format
fs_vs.lazy_load { exclude = vim.g.vscode_snippets_exclude or {} }
fs_vs.lazy_load { paths = vim.g.vscode_snippets_path or "" }

-- snipmate format
fs_sm.load()
fs_sm.lazy_load { paths = vim.g.snipmate_snippets_path or "" }

-- lua format
fs_lua.load()
fs_lua.lazy_load { paths = vim.g.lua_snippets_path or "" }

-- vim.api.nvim_create_autocmd("InsertLeave", {
--   callback = function()
--     if
--       require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
--       and not require("luasnip").session.jump_active
--     then
--       require("luasnip").unlink_current()
--     end
--   end,
-- })
