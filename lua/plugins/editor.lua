return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    tag = "3.14",
    opts = {
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          -- hide_by_name = {
          --   ".git",
          -- },
          never_show = {
            ".git",
          },
        },
      },
      window = {
        position = "left",
        width = 25,
        mappings = {
          ["<space>"] = "none",
        },
      },
      default_component_configs = {
        symlink_target = {
          enabled = true,
        },
      },
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      height = 8,
    },
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
    opts = {
      window = {
        border = "single",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
        delay = 200,
        ignore_whitespace = false,
      },
    },
  },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>gt", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
    },
  },
}
