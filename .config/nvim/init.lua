-- Base Settings
vim.opt.encoding = "utf-8"

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Indent
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
-- vim.g.pyindent_open_paren = vim.bo.shiftwidth

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- vim.wo.number = true
-- vim.wo.relativenumber = true

-- Mouse
vim.opt.mouse = "a"
vim.opt.mousefocus = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Scroll
vim.opt.so = 30

-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- NvimTree
vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>tf', ':NvimTreeFocus<CR>')

-- BufferLine
vim.keymap.set('n','<Tab>', ':BufferLineCycleNext<CR>')
vim.keymap.set('n','<S-Tab>', ':BufferLineCyclePrev<CR>')
vim.keymap.set('n', '<C-l>', ':BufferLineCloseOthers<CR>')

-- TodoList
vim.keymap.set('n', '<leader>nl', ':TodoTelescope<CR>')

-- ToggleTerm
-- vim.keymap.set('n', '<leader>s', ':ToggleTerm')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({

  {
     'hrsh7th/nvim-cmp',
     dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-path'
     },
     config = function()
        local cmp = require 'cmp'
        
        cmp.setup({
              snippet = {
                 -- REQUIRED - you must specify a snippet engine
                 expand = function(args)
                    -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                 end
                 
              },
              window = {
                 completion = cmp.config.window.bordered(),
                 documentation = cmp.config.window.bordered()
              },
              mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({select = true}),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                          if cmp.visible() then
                             cmp.select_next_item()
                          else
                             fallback()
                          end
                    end, {"i", "s"}),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                          if cmp.visible() then
                             cmp.select_prev_item()
                          else
                             fallback()
                          end
                    end, {"i", "s"})
              }),
              sources = cmp.config.sources({
                    {name = 'nvim_lsp'}, {name = 'vsnip'} -- For vsnip users.
                                           }, {{name = 'buffer'}, {name = 'nvim_lsp_signature_help'}})
        })
        
        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
                              sources = cmp.config.sources({
                                    {name = 'cmp_git'} -- You can specify the `cmp_git` source if you were installed it.
                                                           }, {{name = 'buffer'}})
        })
        
        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({'/', '?'}, {
              mapping = cmp.mapping.preset.cmdline(),
              sources = {{name = 'buffer'}}
        })
        
        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
                             mapping = cmp.mapping.preset.cmdline(),
                             sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
        })
        
        -- Set up lspconfig.
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        require('lspconfig')['ts_ls'].setup {capabilities = capabilities}
     end
  },

{
   "neovim/nvim-lspconfig",
   dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
   },

   config = function()
      require("mason").setup({
            ui = {
               icons = {
                  package_installed = "✓",
                  package_pending = "➜",
                  package_uninstalled = "✗"
               }
            }
                            })

      local lspconfig = require('lspconfig')
      lspconfig.pyright.setup {
         settings = {
            pyright = {
               -- Using Ruff's import organizer
               disableOrganizeImports = true,
            },
            python = {
               analysis = {
                  -- Ignore all files for analysis to exclusively use Ruff for linting
                  ignore = { '*' },
               },
            },
         },	
      }

      lspconfig.ts_ls.setup {}

      -- lspconfig.hls.setup{}

      lspconfig.rust_analyzer.setup {
         -- Server-specific settings. See `:help lspconfig-setup`
         settings = {
            ['rust-analyzer'] = {},
         },
      }

      lspconfig.ruff.setup {
         init_options = {
            settings = {
               -- Any extra CLI arguments for `ruff` go here.
               args = {
                  "--select=E,F,UP,N,I,ASYNC,S,PTH",
                  "--line-length=79",
                  "--respect-gitignore",  -- Исключать из сканирования файлы в .gitignore
                  "--target-version=py311"
               },
            }
         }
      }

      
      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      
      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd(
         'LspAttach',
         {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
               -- Enable completion triggered by <c-x><c-o>
               vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
               
               -- Buffer local mappings.
               -- See `:help vim.lsp.*` for documentation on any of the below functions
               local opts = { buffer = ev.buf }
               vim.keymap.set('n', 'lD', vim.lsp.buf.declaration, opts)
               vim.keymap.set('n', 'ld', vim.lsp.buf.definition, opts)
               vim.keymap.set('n', 'lk', vim.lsp.buf.hover, opts)
               -- vim.keymap.set('n', 'lm', vim.lsp.buf.implementation, opts)
               -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
               
               -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
               -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
               -- vim.keymap.set('n', '<space>wl', function()
               --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
               -- end, opts)
               
               -- TODO: Используется повторно, необходимо вырезать в след.версии
               -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
               vim.keymap.set({ 'n', 'v' }, '<space>r', vim.lsp.buf.code_action, opts)
               vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
               vim.keymap.set('n', '<space>f', function()
                                 vim.lsp.buf.format { async = true }
               end, opts)
            end,
         }
      )
   end
},

{
   'numToStr/Comment.nvim',
   -- opts = {}
},

{
   "kylechui/nvim-surround",
   version = "*", -- Use for stability; omit to use `main` branch for the latest features
   event = "VeryLazy",
   config = function()
      require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
      })
   end
},

{
   'echasnovski/mini.nvim', version = false 
},

{ 
   'echasnovski/mini.move', version = false,
   config = function()
      require('mini.move').setup()
   end
},

{ 
   'echasnovski/mini.pairs', version = false,
   config = function()
      require('mini.pairs').setup()
   end
},





{
   "catppuccin/nvim", name = "catppuccin", priority = 1000 
},

{
   "ellisonleao/gruvbox.nvim", priority = 1000 , -- config = true, opts = ...
},

{
   "EdenEast/nightfox.nvim" 
},

{
   "folke/tokyonight.nvim",
   lazy = false,
   priority = 1000,
   -- opts = {},
},

{
   'sainnhe/sonokai',
   lazy = false,
   priority = 1000,
   config = function()
      vim.g.sonokai_style = 'espresso'
      vim.g.sonokai_transparent_background = 1
      vim.g.sonokai_enable_italic = true
      vim.cmd.colorscheme('sonokai')
   end
},

{
   "nvim-treesitter/nvim-treesitter",
   config = function()
      require'nvim-treesitter.configs'.setup {
         ensure_installed = {
            "bash",
            "css",
            "dockerfile",
            "html",
            "javascript",
            "json",
            "json5",
            "lua",
            "python",
            "vim",
            "yaml",
            "c",
            "go",
            "rust",
            "haskell",
         },
         sync_install = false,
         auto_install = true,
         highlight = {
            enable = true,
         },
         indent = {
            enable = true,
         }
      }
   end
},

{
   'nvim-lualine/lualine.nvim',
   dependencies = { 'nvim-tree/nvim-web-devicons' },
   config = function()
      -- Eviline config for lualine
      -- Author: shadmansaleh
      -- Credit: glepnir
      local lualine = require('lualine')

      -- Color table for highlights
      -- stylua: ignore
      local colors = {
         bg       = '#202328',
         fg       = '#bbc2cf',
         yellow   = '#ECBE7B',
         cyan     = '#008080',
         darkblue = '#081633',
         green    = '#98be65',
         orange   = '#FF8800',
         violet   = '#a9a1e1',
         magenta  = '#c678dd',
         blue     = '#51afef',
         red      = '#ec5f67',
      }

      local conditions = {
         buffer_not_empty = function()
            return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
         end,
         hide_in_width = function()
            return vim.fn.winwidth(0) > 80
         end,
         check_git_workspace = function()
            local filepath = vim.fn.expand('%:p:h')
            local gitdir = vim.fn.finddir('.git', filepath .. ';')
            return gitdir and #gitdir > 0 and #gitdir < #filepath
         end,
      }

      -- Config
      local config = {
         options = {
            -- Disable sections and component separators
            component_separators = '',
            section_separators = '',
            theme = {
               -- We are going to use lualine_c an lualine_x as left and
               -- right section. Both are highlighted by c theme .  So we
               -- are just setting default looks o statusline
               normal = { c = { fg = colors.fg, bg = colors.bg } },
               inactive = { c = { fg = colors.fg, bg = colors.bg } },
            },
         },
         sections = {
            -- these are to remove the defaults
            lualine_a = {},
            lualine_b = {},
            lualine_y = {},
            lualine_z = {},
            -- These will be filled later
            lualine_c = {},
            lualine_x = {},
         },
         inactive_sections = {
            -- these are to remove the defaults
            lualine_a = {},
            lualine_b = {},
            lualine_y = {},
            lualine_z = {},
            lualine_c = {},
            lualine_x = {},
         },
      }

      -- Inserts a component in lualine_c at left section
      local function ins_left(component)
         table.insert(config.sections.lualine_c, component)
      end

      -- Inserts a component in lualine_x at right section
      local function ins_right(component)
         table.insert(config.sections.lualine_x, component)
      end

      ins_left {
         function()
            return '▊'
         end,
         color = { fg = colors.blue }, -- Sets highlighting of component
         padding = { left = 0, right = 1 }, -- We don't need space before this
      }

      ins_left {
         -- mode component
         function()
            return ''
         end,
         color = function()
            -- auto change color according to neovims mode
            local mode_color = {
               n = colors.red,
               i = colors.green,
               v = colors.blue,
               [''] = colors.blue,
               V = colors.blue,
               c = colors.magenta,
               no = colors.red,
               s = colors.orange,
               S = colors.orange,
               [''] = colors.orange,
               ic = colors.yellow,
               R = colors.violet,
               Rv = colors.violet,
               cv = colors.red,
               ce = colors.red,
               r = colors.cyan,
               rm = colors.cyan,
               ['r?'] = colors.cyan,
               ['!'] = colors.red,
               t = colors.red,
            }
            return { fg = mode_color[vim.fn.mode()] }
         end,
         padding = { right = 1 },
      }

      ins_left {
         -- filesize component
         'filesize',
         cond = conditions.buffer_not_empty,
      }

      ins_left {
         'filename',
         cond = conditions.buffer_not_empty,
         color = { fg = colors.magenta, gui = 'bold' },
      }

      ins_left { 'location' }

      ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

      ins_left {
         'diagnostics',
         sources = { 'nvim_diagnostic' },
         symbols = { error = ' ', warn = ' ', info = ' ' },
         diagnostics_color = {
            error = { fg = colors.red },
            warn = { fg = colors.yellow },
            info = { fg = colors.cyan },
         },
      }

      -- Insert mid section. You can make any number of sections in neovim :)
      -- for lualine it's any number greater then 2
      ins_left {
         function()
            return '%='
         end,
      }

      ins_left {
         -- Lsp server name .
         function()
            local msg = 'No Active Lsp'
            local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
            local clients = vim.lsp.get_clients()
            if next(clients) == nil then
               return msg
            end
            for _, client in ipairs(clients) do
               local filetypes = client.config.filetypes
               if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  return client.name
               end
            end
            return msg
         end,
         icon = ' LSP:',
         color = { fg = '#ffffff', gui = 'bold' },
      }

      -- Add components to right sections
      ins_right {
         'o:encoding', -- option component same as &encoding in viml
         fmt = string.upper, -- I'm not sure why it's upper case either ;)
         cond = conditions.hide_in_width,
         color = { fg = colors.green, gui = 'bold' },
      }

      ins_right {
         'fileformat',
         fmt = string.upper,
         icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
         color = { fg = colors.green, gui = 'bold' },
      }

      ins_right {
         'branch',
         icon = '',
         color = { fg = colors.violet, gui = 'bold' },
      }

      ins_right {
         'diff',
         -- Is it me or the symbol for modified us really weird
         symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
         diff_color = {
            added = { fg = colors.green },
            modified = { fg = colors.orange },
            removed = { fg = colors.red },
         },
         cond = conditions.hide_in_width,
      }

      ins_right {
         function()
            return '▊'
         end,
         color = { fg = colors.blue },
         padding = { left = 1 },
      }

      -- Now don't forget to initialize lualine
      lualine.setup(config)
   end
},

{
   'Eandrju/cellular-automaton.nvim',
   config = function()
      local config = {
         fps = 50,
         name = 'slide',
      }

      -- update function
      config.update = function (grid)
         for i = 1, #grid do
            local prev = grid[i][#(grid[i])]
            for j = 1, #(grid[i]) do
               grid[i][j], prev = prev, grid[i][j]
            end
         end
         return true
      end
      
      require("cellular-automaton").register_animation(config)
   end
},

{
   'nvimdev/dashboard-nvim',
   event = 'VimEnter',
   dependencies = {{'nvim-tree/nvim-web-devicons'}},
   config = function()
      require('dashboard').setup {
         theme = 'doom',
         config = {
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
                  icon = '󰈞 ',
                  icon_hl = 'Title',
                  desc = 'Find files',
                  desc_hl = 'String',
                  key = 'f',
                  keymap = 'SPC f f',
                  key_hl = 'Number',
                  action = ':Telescope find_files'
               }, {
                  icon = '󰱾 ',
                  icon_hl = 'Title',
                  desc = 'Open recently',
                  desc_hl = 'String',
                  key = 'r',
                  keymap = 'SPC f r',
                  key_hl = 'Number',
                  action = ':Telescope oldfiles'
                  }, {
                  icon = ' ',
                  icon_hl = 'Title',
                  desc = 'Find text',
                  desc_hl = 'String',
                  key = 'w',
                  keymap = 'SPC f w',
                  key_hl = 'Number',
                  action = ':Telescope live_grep'
                     }, {
                  icon = ' ',
                  icon_hl = 'Title',
                  desc = 'Git Braches',
                  desc_hl = 'String',
                  key = 'b',
                  keymap = 'SPC g b',
                  key_hl = 'Number',
                  action = ':Telescope git_branches'
                        }

            }
         }
      }

   end
},

{ 
   'norcalli/nvim-colorizer.lua' 
},

{
   "lukas-reineke/indent-blankline.nvim",
   main = "ibl",
   ---@module "ibl"
   ---@type ibl.config
   opts = {
      indent = { char = "│" }, 
      scope = { enabled = false },
      -- node_type = { '*' = { "source_file" } },
      exclude = {
         filetypes = {
            "dashboard",
         },
      },
   },
},

{
   "folke/todo-comments.nvim",
   dependencies = { "nvim-lua/plenary.nvim" },
   -- opts = {}
},

{
   'akinsho/bufferline.nvim', version = "*",
   version = "*",
   dependencies = 'nvim-tree/nvim-web-devicons',
   config = function()
      require("bufferline").setup {}
   end
},

{
   "nvim-tree/nvim-tree.lua",
   version = "*",
   lazy = false,
   dependencies = {
      "nvim-tree/nvim-web-devicons",
   },
   config = function()
      require("nvim-tree").setup({
            renderer = {
               indent_width = 1,
               indent_markers = {
                  enable = true,
                  icons = {
                     corner = ' ',--'└',
                     edge = '│',-- '│',
                     item = ' ',--'│',
                     none = '│'
                  }
               }
            },
            filters = {
               git_ignored = false
            }
      })
   end
},

{
   'nvim-telescope/telescope.nvim', tag = '0.1.8',
   -- or                          , branch = '0.1.x',
   dependencies = { 'nvim-lua/plenary.nvim' },
   config = function()
      -- Настраиваем комбинации под разные функции
      local builtin = require('telescope.builtin')

      -- Работа с файлами и буфферами
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>ft', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

      -- Работа с Git
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
      vim.keymap.set('n', '<leader>gs', builtin.git_status, {})

      -- Выбор цветовой схемы
      vim.keymap.set('n', '<leader>cs', builtin.colorscheme, {})
   end
},

{
   "folke/which-key.nvim",
   event = "VeryLazy",
   -- opts = {icons = {mappings = false}},
   config = function()
      local wk = require("which-key")

      wk.add({

            { "<leader>c", group = "Color Schemes" },
            { "<leader>cs", desc = "Open" },

            { "<leader>e", desc = "Open Diagnostic Window" },

            { "<leader>f", group = "Find" },
            { "<leader>fb", desc = "Find Buffer" },
            { "<leader>ff", desc = "Find File" },
            { "<leader>fh", desc = "Find Help" },
            { "<leader>ft", desc = "Find Text" },

            { "<leader>g", group = "Git" },
            { "<leader>gb", desc = "Open Branches" },
            { "<leader>gc", desc = "Open Commits" },
            { "<leader>gs", desc = "Open Status" },

            { "<leader>l", group = "LSP" },
            { "<leader>lD", desc = "Declaration" },
            { "<leader>ld", desc = "Definition" },
            { "<leader>lk", desc = "Hover" },
            
            { "<leader>n", group = "TodoList" },
            { "<leader>nl", desc = "Open List" },

            { "<leader>r", desc = "Ruff" },

            { "<leader>s", desc = "Open Terminal" },

            { "<leader>t", group = "NvimTree" },
            { "<leader>tf", desc = "Tree Focus" },
            { "<leader>tt", desc = "Tree Toggle" },
      })
   end
},

})
