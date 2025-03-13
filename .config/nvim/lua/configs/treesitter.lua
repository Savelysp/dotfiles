require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "c",
    "css",
    "dockerfile",
    "go",
    "haskell",
    "html",
    "javascript",
    "json",
    "lua",
    "python",
    "query",
    "rust",
    "vim",
    "yaml",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
  },
})
