return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      term_colors = false,
      transparent_background = true,
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
          red = "#fa5252",
        },
      },
      highlight_overrides = {
        all = function(colors)
          return {
            TSVariable = { fg = colors.text },
            TSVariableBuiltin = { fg = colors.mauve },
            ["@variable"] = { link = "TSVariable" },
            ["@variable.builtin"] = { link = "TSVariableBuiltin" },
            ["@lsp.type.variable"] = { link = "TSVariable" },
            TSNamespace = { fg = colors.yellow },
            ["@namespace"] = { link = "TSNamespace" },
            ["@lsp.type.namespace"] = { link = "TSNamespace" },
          }
        end,
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    enabled = false,
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
