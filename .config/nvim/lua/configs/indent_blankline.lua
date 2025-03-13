require("ibl").setup({
  indent = { char = "│" },
  scope = { enabled = false },
  -- node_type = { '*' = { "source_file" } },
  exclude = {
    filetypes = {
      "dashboard",
      "terminal",
      "help",
    },
  },
})
