require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true, -- Всегда делить среднюю секцию на две части
  },

  sections = {
    lualine_a = {},
    lualine_b = {'location', 'progress', 'filename'},
    lualine_c = {'diff', 'diagnostics', 'lsp_client_names'},
    lualine_x = {},
    lualine_y = {'branch'},
    lualine_z = {'encoding', 'fileformat', 'filetype'},
  },

  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {},
  },

  tabline = {},
  extensions = {}
})
