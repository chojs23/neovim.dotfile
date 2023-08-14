return {
  { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    opts = {
      transparency = true,
    },
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      style = "night",
      styles = {
        comments = { italic = true },
      },
      transparent = true,
      on_colors = function(colors)
        colors.bg = "#000000"
        colors.bg_dark = "#000000"
        colors.bg_float = "#000000"
        colors.bg_highlight = "#101010"
        colors.bg_statusline = "#000000"
        colors.bg_sidebar = "#000000"
        colors.git = {
          add = "#24bf55",
          change = "#2453bf",
          delete = "#ba1a37",
          ignore = "#545c7e",
        }
        colors.gitSigns = {
          add = "#24bf55",
          change = "#2453bf",
          delete = "#ba1a37",
        }
      end,
      on_highlights = function(hl, colors)
        hl.LineNr = {
          fg = colors.dark5,
        }
        hl.CursorLineNr = {
          fg = colors.dark5,
        }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "HiPhish/nvim-ts-rainbow2",
  },
}
