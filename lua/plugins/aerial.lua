require("aerial").setup({
  attach_mode = "global",
  backends = { "lsp", "treesitter", "markdown", "man" },
  layout = {
    resize_to_content = false,
  },
  show_guides = true,
})

vim.keymap.set("n", "<leader>cs", "<cmd>AerialToggle<cr>", { desc = "Aerial symbols" })
