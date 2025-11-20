return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            ".git",
          },
          -- never_show = {
          --   ".git",
          -- },
        },
        window = {},
      }
      opts.window = {
        position = "left",
        width = 25,
        mappings = {
          ["<space>"] = "none",
          ["/"] = "none",
          ["#"] = "fuzzy_sorter",
        },
      }
      opts.default_component_configs = {
        symlink_target = {
          enabled = true,
        },
      }
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      mode = "fuzzy",
      modes = {
        search = {
          enabled = false,
        },
        char = {
          keys = { "f", "F" },
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function(_, opts)
      opts.win = {
        border = "single",
      }
      require("which-key").setup(opts)
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 500,
        ignore_whitespace = false,
      },
    },
  },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>t", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
    },
  },
  {
    "petertriho/nvim-scrollbar",
    config = function(_, opts)
      require("scrollbar.handlers.search").setup()
      require("scrollbar.handlers.gitsigns").setup()

      require("scrollbar").setup(opts)
    end,
  },
}
