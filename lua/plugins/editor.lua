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
          -- hide_by_name = {
          --   ".git",
          -- },
          never_show = {
            ".git",
          },
        },
        commands = {
          avante_add_files = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local relative_path = require("avante.utils").relative_path(filepath)

            local sidebar = require("avante").get()

            local open = sidebar:is_open()
            -- ensure avante sidebar is open
            if not open then
              require("avante.api").ask()
              sidebar = require("avante").get()
            end

            sidebar.file_selector:add_selected_file(relative_path)

            -- remove neo tree buffer
            if not open then
              sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
            end
          end,
        },
        window = {
          mappings = {
            ["oa"] = "avante_add_files",
          },
        },
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
}
