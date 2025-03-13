require("dashboard").setup({
  theme = 'doom',
  hide = {
    statusline = false,
    tabline = true,
    winbar = true,
  },
  config ={
    header = {
      '', '', '',
      '██╗███████╗██╗   ██╗██╗███╗   ███╗',
      '██║██╔════╝██║   ██║██║████╗ ████║',
      '██║█████╗  ██║   ██║██║██╔████╔██║',
      '██║██╔══╝  ╚██╗ ██╔╝██║██║╚██╔╝██║',
      '██║██║      ╚████╔╝ ██║██║ ╚═╝ ██║',
      '╚═╝╚═╝       ╚═══╝  ╚═╝╚═╝     ╚═╝',
      '', '', ''
    },
    center = {
      {
        icon = 'F ',
        icon_hl = 'Title',
        desc = 'Find files',
        desc_hl = 'String',
        key = 'f',
        keymap = 'SPC f f',
        key_hl = 'Number',
        key_format = ' [%s]',
        action = ':Telescope find_files',
      },
      {
        icon = 'F ',
        icon_hl = 'Title',
        desc = 'Open oldfiles',
        desc_hl = 'String',
        key = 'o',
        keymap = 'SPC f o',
        key_hl = 'Number',
        key_format = ' [%s]',
        action = ':Telescope oldfiles',
      },
      {
        icon = 'F ',
        icon_hl = 'Title',
        desc = 'Find text',
        desc_hl = 'String',
        key = 't',
        keymap = 'SPC f t',
        key_hl = 'Number',
        key_format = ' [%s]',
        action = ':Telescope live_grep',
      },
      {
        icon = 'F ',
        icon_hl = 'Title',
        desc = 'Git Braches',
        desc_hl = 'String',
        key = 'b',
        keymap = 'SPC g b',
        key_hl = 'Number',
        key_format = ' [%s]',
        action = ':Telescope git_branches',
      },
    },
    footer = {"hello world"},
    vertical_center = false,
  },
})
