return {
  -- { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000, enabled = false },
  -- {
  --   "olimorris/onedarkpro.nvim",
  --   priority = 1000,
  --   opts = {
  --     transparency = true,
  --   },
  --   enabled = false,
  -- },
  { "ap/vim-css-color" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      term_colors = false,
      transparent_background = false,
      styles = {
        comments = {},
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
      },
      color_overrides = {
        mocha = {
          base = "#080808",
          mantle = "#151515",
          crust = "#ffffff",
        },
      },
      -- color_overrides = {
      --   mocha = {
      --     rosewater = "#ffc9c9",
      --     flamingo = "#ff9f9a",
      --     pink = "#ffa9c9",
      --     mauve = "#df95cf",
      --     lavender = "#a990c9",
      --     red = "#ff6960",
      --     maroon = "#f98080",
      --     peach = "#f9905f",
      --     yellow = "#f9bd69",
      --     green = "#b0d080",
      --     teal = "#a0dfa0",
      --     sky = "#a0d0c0",
      --     sapphire = "#95b9d0",
      --     blue = "#89a0e0",
      --     text = "#e0d0b0",
      --     subtext1 = "#d5c4a1",
      --     subtext0 = "#bdae93",
      --     overlay2 = "#928374",
      --     overlay1 = "#7c6f64",
      --     overlay0 = "#665c54",
      --     surface2 = "#504844",
      --     surface1 = "#3a3634",
      --     surface0 = "#252525",
      --     base = "#151515",
      --     mantle = "#080808",
      --     crust = "#ffffff",
      --   },
      -- },
    },
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      style = "night",
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
      },
      sidebars = { "qf", "vista_kind", "terminal", "packer", "help" },
      transparent = false,
      on_colors = function(colors)
        colors.bg = "#000000"
        colors.bg_dark = "#000000"
        colors.bg_float = "#000000"
        colors.bg_highlight = "#121212"
        colors.bg_statusline = "#000000"
        colors.bg_sidebar = "#000000"
        colors.fg_gutter = "#2c2c2c"
        colors.border = "#e0e0e0"
        colors.git = {
          add = "#24bf55",
          change = "#FFCB6B",
          delete = "#ba1a37",
          ignore = "#545c7e",
        }
        colors.gitSigns = {
          add = "#24bf55",
          change = "#FFCB6B",
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
        hl.NeoTreeGitAdded = {
          fg = "#24bf55",
        }
        hl.NeoTreeGitDeleted = {
          fg = "#ba1a37",
        }
        hl.NeoTreeGitModified = {
          fg = "#FFCB6B",
        }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
