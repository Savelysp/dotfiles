local wk = require("which-key")

-- Базовая настройка which-key
-- wk.setup({
--   plugins = {
--     marks = true, -- показывать маркеры
--     registers = true, -- показывать регистры
--     spelling = {
--       enabled = true, -- включить проверку орфографии
--       suggestions = 20, -- количество предложений
--     },
--     presets = {
--       operators = true, -- показывать операторы (например, d, y, c)
--       motions = true, -- показывать движения (например, w, b, e)
--       text_objects = true, -- показывать текстовые объекты (например, iw, aw)
--       windows = true, -- показывать команды для работы с окнами
--       nav = true, -- показывать навигацию (например, hjkl)
--       z = true, -- показывать команды для работы с регистром z
--       g = true, -- показывать команды для работы с регистром g
--     },
--   },
--   show_help = true, -- показывать помощь
-- })

-- Регистрация пользовательских ключевых связок
wk.add({
    { "<leader>f", group = "file" },
    { "<leader>g", group = "git" },
})
