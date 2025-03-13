local map = vim.keymap.set

--------------------------------------------------

-- Insert mode movement mappings
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

-- Command mode
map("n", ";", ":", { desc = "CMD enter command mode" })

-- Exit Insert mode
map("i", "jk", "<ESC>")

-- Normal mode window movement
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

-- Сброс подсветки поиска
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

-- Работа с файлом
map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

-- Переключение нумерации
map("n", "<leader>nn", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>nr", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })

-- Комментирование
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })


-- nvim-tree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>t", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })


-- telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map("n", "<leader>ft", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "telescope git branches" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })

-- map("n", "<leader>cs", "<cmd>Telescope colorscheme<CR>", { desc = "telescope themes" })
vim.keymap.set("n", "<leader>cs", function()
    require("telescope.builtin").colorscheme({ enable_preview = true })
end, { desc = "telescope colorscheme with preview" })


-- bufferline
-- Переключение между буферами
map("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Следующий буфер" })
map("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Предыдущий буфер" })

-- Закрытие буферов
map("n", "<leader>bc", "<Cmd>BufferLinePickClose<CR>", { desc = "Закрыть выбранный буфер" })
map("n", "<leader>bC", "<Cmd>BufferLineCloseLeft<CR><Cmd>BufferLineCloseRight<CR>", { desc = "Закрыть все буферы, кроме текущего" })

-- Перемещение буферов
map("n", "<leader>bl", "<Cmd>BufferLineMoveNext<CR>", { desc = "Переместить буфер вправо" })
map("n", "<leader>bh", "<Cmd>BufferLineMovePrev<CR>", { desc = "Переместить буфер влево" })

-- Выбор буфера по номеру
map("n", "<leader>b1", "<Cmd>BufferLineGoToBuffer 1<CR>", { desc = "Перейти к буферу 1" })
map("n", "<leader>b2", "<Cmd>BufferLineGoToBuffer 2<CR>", { desc = "Перейти к буферу 2" })
map("n", "<leader>b3", "<Cmd>BufferLineGoToBuffer 3<CR>", { desc = "Перейти к буферу 3" })
map("n", "<leader>b4", "<Cmd>BufferLineGoToBuffer 4<CR>", { desc = "Перейти к буферу 4" })
map("n", "<leader>b5", "<Cmd>BufferLineGoToBuffer 5<CR>", { desc = "Перейти к буферу 5" })
map("n", "<leader>b6", "<Cmd>BufferLineGoToBuffer 6<CR>", { desc = "Перейти к буферу 6" })
map("n", "<leader>b7", "<Cmd>BufferLineGoToBuffer 7<CR>", { desc = "Перейти к буферу 7" })
map("n", "<leader>b8", "<Cmd>BufferLineGoToBuffer 8<CR>", { desc = "Перейти к буферу 8" })
map("n", "<leader>b9", "<Cmd>BufferLineGoToBuffer 9<CR>", { desc = "Перейти к буферу 9" })

-- Выбор буфера через меню
map("n", "<leader>bp", "<Cmd>BufferLinePick<CR>", { desc = "Выбрать буфер из списка" })

-- Сортировка буферов
map("n", "<leader>bs", "<Cmd>BufferLineSortByTabs<CR>", { desc = "Сортировать буферы по вкладкам" })

-- Вкладки
map("n", "<leader>wn", "<Cmd>tabnew<CR>", { desc = "Новая вкладка" })
map("n", "<leader>wc", "<Cmd>tabclose<CR>", { desc = "Закрыть вкладку" })
map("n", "<leader>wj", "<Cmd>tabnext<CR>", { desc = "Следующая вкладка" })
map("n", "<leader>wk", "<Cmd>tabprev<CR>", { desc = "Предыдущая вкладка" })
