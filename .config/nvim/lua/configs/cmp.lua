local cmp = require 'cmp'

-- Основная настройка nvim-cmp
cmp.setup({
    snippet = {
        -- Обязательный параметр: указываем движок сниппетов
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- Используем luasnip (можно заменить)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(), -- Окно автодополнения с границами
        documentation = cmp.config.window.bordered(), -- Окно документации с границами
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Прокрутка документации вверх
        ['<C-f>'] = cmp.mapping.scroll_docs(4), -- Прокрутка документации вниз
        ['<C-Space>'] = cmp.mapping.complete(), -- Вызов меню автодополнения
        ['<C-e>'] = cmp.mapping.abort(), -- Закрытие меню автодополнения
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Подтверждение выбора
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item() -- Переключение на следующий элемент
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item() -- Переключение на предыдущий элемент
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- Используем luasnip вместо vsnip
    }, {
        { name = 'buffer' },
        { name = 'nvim_lsp_signature_help' },
    })
})

-- Настройка для файлов типа gitcommit
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- Источник для git
    }, {
        { name = 'buffer' },
    })
})

-- Автодополнение в командной строке для `/` и `?`
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' },
    }
})

-- Автодополнение в командной строке для `:` (команд)
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline' },
    })
})
