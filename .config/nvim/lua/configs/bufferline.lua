require("bufferline").setup({
  options = {
    mode = "buffers", -- или "tabs" для отображения вкладок
    numbers = "none", -- или "ordinal", "buffer_id"
    close_command = "bdelete! %d", -- команда для закрытия буфера
    right_mouse_command = "bdelete! %d", -- команда для закрытия буфера по правому клику
    left_mouse_command = "buffer %d", -- команда для переключения на буфер по левому клику
    middle_mouse_command = nil, -- команда для средней кнопки мыши
    indicator = {
      icon = '▎', -- индикатор текущего буфера
      style = 'icon', -- или 'underline'
    },
    -- buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15,
    tab_size = 18,
    diagnostics = "nvim_lsp", -- или "coc"
    diagnostics_update_in_insert = false,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      },
    },
    color_icons = true, -- использовать цветные иконки
    show_buffer_icons = true, -- показывать иконки буферов
    show_buffer_close_icons = true, -- показывать иконки закрытия буферов
    show_close_icon = true, -- показывать иконку закрытия
    show_tab_indicators = true, -- показывать индикаторы вкладок
    persist_buffer_sort = true, -- сохранять порядок буферов
    separator_style = "thin", -- или "thick", "slant"
    enforce_regular_tabs = false,
    always_show_bufferline = true,
  },
  highlights = {
    fill = {
      bg = "None", -- Прозрачный фон для всей панели bufferline
    },
  },
})
