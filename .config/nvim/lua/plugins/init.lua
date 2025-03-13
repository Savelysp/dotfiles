return {
--------------------------------------------------
  { -- nvim-lspconfig, lsp_signature.nvim
    "neovim/nvim-lspconfig",
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require("configs.lspconfig")
    end,
  },
--------------------------------------------------
  { -- mason.nvim
    'williamboman/mason.nvim',
    config = function()
      require("configs.mason")
    end,
  },
--------------------------------------------------
  { -- nvim-cmp (alternative: coq.nvim)
    'hrsh7th/nvim-cmp',
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path'
    },
    config = function()
      require("configs.cmp")
    end,
  },
--------------------------------------------------
  { -- nvim-dap
  },
--------------------------------------------------
  { -- nvim-tree.lua
    "nvim-tree/nvim-tree.lua",
    -- version = "*",
    -- lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("configs.nvimtree")
    end,
  },
  --------------------------------------------------
  { -- which-key.nvim
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("configs.whichkey")
    end,
  },
--------------------------------------------------
  { -- gitsigns.nvim
    "lewis6991/gitsigns.nvim",
    config = function()
      require("configs.gitsigns")
    end,
  },
--------------------------------------------------
  { -- LuaSnip
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("configs.luasnip")
    end,
  },
--------------------------------------------------
  { -- telescope.nvim
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require("configs.telescope")
    end,
  },
--------------------------------------------------
  { -- nvim-treesitter
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("configs.treesitter")
    end,
  },
--------------------------------------------------
  { -- bufferline.nvim
    'akinsho/bufferline.nvim',
    -- version = "*",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require("configs.bufferline")
    end,
  },
--------------------------------------------------
  { -- lualine.nvim
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require("configs.evil_lualine")
    end,
  },
--------------------------------------------------
  { -- dashboard-nvim (alternative: alpha-nvim)
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require("configs.dashboard")
    end,
  },
--------------------------------------------------
  { -- toggleterm.nvim
    'akinsho/toggleterm.nvim',
    config = function()
      require("configs.toggleterm")
    end,
  },
--------------------------------------------------
  -- { -- noice.nvim
  --   'folke/noice.nvim',
  --   event = "VeryLazy",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "rcarriga/nvim-notify",
  --   },
  --   config = function()
  --     require("configs.noice")
  --   end,
  -- },
--------------------------------------------------
  { -- cellular-automaton.nvim
    'Eandrju/cellular-automaton.nvim',
    config = function()
      require("configs.cellular_automaton")
    end,
  },
--------------------------------------------------
  { -- todo-comments.nvim
    'folke/todo-comments.nvim',
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("configs.todo_comments")
    end,
  },
--------------------------------------------------
  { -- nvim-colorizer.lua
    'norcalli/nvim-colorizer.lua',
    config = function()
      require("colorizer").setup()
    end,
  },
--------------------------------------------------
  { -- indent-blankline.nvim
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    config = function()
      require("configs.indent_blankline")
    end,
  },
--------------------------------------------------
  { -- nvim-autopairs ??????????????????
  },
--------------------------------------------------
  { -- nvim-surround ?????????????/
  },
--------------------------------------------------
  { -- Comment.nvim ???????????????????
  },
--------------------------------------------------
  { -- Mini (pairs, ai, icons, surround, move)
  },
  --------------------------------------------------
  { -- catppuccin
    'catppuccin/nvim',
    name = "catppuccin",
    config = function()
      require('catppuccin').setup({
        transparent_background = true,
      })
      vim.cmd.colorscheme('catppuccin')
    end,
  },
--------------------------------------------------
  { -- gruvbox
    'ellisonleao/gruvbox.nvim',
  },
--------------------------------------------------
  { -- nightfox
    'EdenEast/nightfox.nvim',
  },
--------------------------------------------------
  { -- tokyonight
    'folke/tokyonight.nvim',
  },
--------------------------------------------------
  { -- sonokai
   'sainnhe/sonokai',
  },
--------------------------------------------------
  { -- kanagawa
    'rebelot/kanagawa.nvim',
  },
--------------------------------------------------
  { -- onedark
    'navarasu/onedark.nvim',
  },
--------------------------------------------------
  { -- everforest
    'sainnhe/everforest',
  },
--------------------------------------------------
  { -- rose-pine
    'rose-pine/neovim',
  },
--------------------------------------------------
  { -- oxocarbon
    'nyoom-engineering/oxocarbon.nvim',
  },
--------------------------------------------------
  { -- nord
    'shaunsingh/nord.nvim',
  },
--------------------------------------------------
  { -- dracula
    'Mofiqul/dracula.nvim',
  },
--------------------------------------------------
  { -- doom-one
    'NTBBloodbath/doom-one.nvim',
  },
--------------------------------------------------
  { -- (hop, project, harpoon, nvim-ufo, flash.nvim, leap, lspsaga, duck, typewriter, deal with it, cool retro term, snacks, oil, trouble, vim be good)
  },
--------------------------------------------------
  { --
  },
--------------------------------------------------

}
