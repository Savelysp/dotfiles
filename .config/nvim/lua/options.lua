local opt = vim.opt
local o = vim.o
local g = vim.g

--------------------------------------------------

-- Статус панель
o.laststatus = 3
o.showmode = false

-- Буфер обмена
o.clipboard = "unnamedplus"

-- Выделение строки
o.cursorline = true
o.cursorlineopt = "number"

-- Отступы
o.expandtab = true   -- Использовать пробелы вместо табов
o.shiftwidth = 2     -- Размер отступа при сдвиге
o.smartindent = true -- Автоматически добавлять отступы в новых строках
o.tabstop = 2        -- Количество пробелов, в табе
o.softtabstop = 2    -- Сколько пробелов удаляется при нажатии Backspace
o.autoindent = true  -- Копирует отступ предыдущей строки
o.smarttab = true    -- Чуть более умный таб

-- Уберает символы в конце буфера
opt.fillchars = { eob = " " }

-- Умный поиск
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true

-- Мышь
o.mouse = "a"
o.mousefocus = true

-- Минимальный отступ при прокрутке.
vim.opt.scrolloff = 30

-- Нумерация строк
o.number = true
o.relativenumber = true
o.numberwidth = 2
o.ruler = false

-- Отключить nvim intro
opt.shortmess:append "sI"

-- Отображение колонки значков
o.signcolumn = "yes"

-- Поведение сплитов
o.splitbelow = true
o.splitright = true

-- Время ожидания в миллисекундах для ввода комманд
o.timeoutlen = 400

-- Включить файлы истории отмен
o.undofile = true

-- Время в миллисекундах перед записью swap-файла (время неактивности)
o.updatetime = 250

-- Разрешить переход к следующей/предыдущей строке с помощью клавиш h, l
opt.whichwrap:append "<>[]hl"

-- Отключение встроенных провайдеров Neovim для разных языков (ускоряет загрузку)
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
