local lsp = require('lspconfig')
-- local m_lsp = require('mason-lspconfig')

-- m_lsp.setup({
--   nsure_installed = {
--     "pyright",
--     "ruff",
--     "mypy",
--   },
--   automatic_installation = true,
-- })

lsp.pyright.setup({
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { '*' },
      },
    },
  },
})

lsp.ruff.setup({
  init_options = {
    settings = {
      args = {
        "--select=E,F,UP,N,I,ASYNC,S,PTH",
        "--line-length=79",
        "--respect-gitignore",
      },
    },
  },
})


-- Глобальные биндинги для работы с диагностикой LSP
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)  -- Открываем всплывающее окно с ошибками
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)  -- Переход к предыдущей ошибке
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)  -- Переход к следующей ошибке

-- Автокоманда: настраивает LSP только после подключения к буферу
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'  -- Включаем встроенную LSP-комплектацию

    local opts = { buffer = ev.buf }  -- Привязываем клавиши только к текущему буферу
    vim.keymap.set('n', 'lD', vim.lsp.buf.declaration, opts)  -- Перейти к объявлению
    vim.keymap.set('n', 'ld', vim.lsp.buf.definition, opts)  -- Перейти к определению
    vim.keymap.set('n', 'lk', vim.lsp.buf.hover, opts)  -- Показать документацию (hover)
    vim.keymap.set('n', 'li', vim.lsp.buf.implementation, opts)  -- Показать реализации функции/метода
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)  -- Показать информацию о сигнатуре функции
    vim.keymap.set({ 'n', 'v' }, '<space>r', vim.lsp.buf.code_action, opts)  -- Предложить исправления (code actions)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)  -- Найти все ссылки на объект
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }  -- Форматировать код с использованием LSP
    end, opts)
  end,
})
