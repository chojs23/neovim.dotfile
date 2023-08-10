-- Lua initialization file
vim.g.moonflyVirtualTextColor = true

return {
  { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
  { "ful1e5/onedark.nvim", name = "onedark", lazy = false, priority = 1000 },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "moonfly",
    },
  },
}
