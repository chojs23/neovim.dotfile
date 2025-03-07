return {
  {
    "tpope/vim-dispatch",
  },
  {
    "radenling/vim-dispatch-neovim",
    dependencies = "tpope/vim-dispatch",
  },
  {
    "gorbit99/codewindow.nvim",
    opts = function()
      local codewindow = require("codewindow")
      codewindow.setup({
        active_in_terminals = false, -- Should the minimap activate for terminal buffers
        auto_enable = false, -- Automatically open the minimap when entering a (non-excluded) buffer (accepts a table of filetypes)
        exclude_filetypes = { "help" }, -- Choose certain filetypes to not show minimap on
        max_minimap_height = nil, -- The maximum height the minimap can take (including borders)
        max_lines = 4000, -- If auto_enable is true, don't open the minimap for buffers which have more than this many lines.
        minimap_width = 6, -- The width of the text part of the minimap
        use_lsp = true, -- Use the builtin LSP to show errors and warnings
        use_treesitter = true, -- Use nvim-treesitter to highlight the code
        use_git = true, -- Show small dots to indicate git additions and deletions
        width_multiplier = 8, -- How many characters one dot represents
        z_index = 1, -- The z-index the floating window will be on
        show_cursor = true, -- Show the cursor position in the minimap
        screen_bounds = "lines", -- How the visible area is displayed, "lines": lines above and below, "background": background color
        window_border = "single", -- The border style of the floating window (accepts all usual options)
        relative = "win", -- What will be the minimap be placed relative to, "win": the current window, "editor": the entire editor
        events = { "TextChanged", "InsertLeave", "DiagnosticChanged", "FileWritePost" }, -- Events that update the code window
      })
      codewindow.apply_default_keybinds()
    end,
  },
  --   {
  --     "saghen/blink.cmp",
  --     opts = {
  --       completion = {
  --         ghost_text = {
  --           enabled = false,
  --         },
  --         list = {
  --           selection = "auto_insert",
  --         },
  --         menu = {
  --           border = "rounded",
  --           winhighlight = "Normal:NormalFloat,FloatBorder:NormalFloat,CursorLine:BlinkCmpMenuSelection,Search:None",
  --         },
  --         documentation = {
  --           auto_show = true,
  --           window = {
  --             border = "rounded",
  --           },
  --         },
  --       },
  --       keymap = {
  --         preset = "enter",
  --         ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
  --         ["enter"] = {
  --           function(cmp)
  --             if cmp.snippet_active() then
  --               return cmp.accept()
  --             else
  --               return cmp.select_and_accept()
  --             end
  --           end,
  --           "snippet_forward",
  --           "fallback",
  --         },
  --         ["<C-p>"] = { "select_prev", "fallback" },
  --         ["<C-n>"] = { "select_next", "fallback" },
  --
  --         ["<S-Tab>"] = { "select_prev", "fallback" },
  --         ["<Tab>"] = { "select_next", "fallback" },
  --
  --         ["<C-b>"] = { "scroll_documentation_up", "fallback" },
  --         ["<C-f>"] = { "scroll_documentation_down", "fallback" },
  --         ["<C-y>"] = {},
  --       },
  --     },
  --     config = function(_, opts)
  --       require("blink.cmp").setup(opts)
  --     end,
  --   },
  {
    "gbprod/yanky.nvim",
    desc = "Better Yank/Paste",
    event = "LazyFile",
    opts = {
      highlight = { timer = 150 },
    },
    keys = {
        -- stylua: ignore
    { "<leader>y", function() require("telescope").extensions.yank_history.yank_history({ }) end, desc = "Open Yank History" ,mode= {"n","x"}},
    },
  },
  {
    "echasnovski/mini.pairs",
    version = false,
    event = "VeryLazy",
    opts = {
      mappings = {
        ["'"] = false,
        ['"'] = false,
        ["`"] = false,
      },
    },
  },
  {
    "sindrets/diffview.nvim",
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
      -- "ibhagwan/fzf-lua", -- optional
    },
    config = true,
    opts = {
      disable_context_highlighting = false,
      disable_line_numbers = false,
      integrations = {
        -- If enabled, use telescope for menu selection rather than vim.ui.select.
        -- Allows multi-select and some things that vim.ui.select doesn't.
        telescope = true,
        -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `diffview`.
        -- The diffview integration enables the diff popup.
        --
        -- Requires you to have `sindrets/diffview.nvim` installed.
        diffview = true,

        -- If enabled, uses fzf-lua for menu selection. If the telescope integration
        -- is also selected then telescope is used instead
        -- Requires you to have `ibhagwan/fzf-lua` installed.
        fzf_lua = nil,
      },
      mappings = {
        finder = {
          ["<tab>"] = "Next",
          ["<s-tab>"] = "Previous",
          ["<down>"] = "MultiselectToggleNext",
          ["<up>"] = "MultiselectTogglePrevious",
        },
      },
    },
    keys = {
      { "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit" },
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview open" },
    },
  },
  {
    "stevearc/oil.nvim",
    opts = {
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ["<leader>o"] = "actions.close",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
      },
      view_options = {
        show_hidden = true,
      },
    },
    enabled = true,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = { { "<leader>o", "<cmd>Oil<cr>", desc = "Open parent directory" } },
  },
  {
    "andweeb/presence.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {
      -- General options
      auto_update = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
      neovim_image_text = "ㅇㅅㅇ", -- Text displayed when hovered over the Neovim image
      main_image = "file", -- Main image display (either "neovim" or "file")
      client_id = "793271441293967371", -- Use your own Discord application client id (not recommended)
      log_level = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
      debounce_timeout = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
      enable_line_number = true, -- Displays the current line number instead of the current project
      blacklist = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
      buttons = false, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
      file_assets = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
      show_time = true, -- Show the timer

      -- Rich Presence text options
      editing_text = function(filename) -- filename arg doesn't need to be used here
        -- Determine type of file using vim's &filetype variable
        local filetype = vim.bo.filetype:gsub("^%l", string.upper)
        return string.format("Editing a %s file", filetype)
      end,
      file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
      git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
      plugin_manager_text = "Managing %s", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
      reading_text = function(filename) -- filename arg doesn't need to be used here
        -- Determine type of file using vim's &filetype variable
        local filetype = vim.bo.filetype:gsub("^%l", string.upper)
        return string.format("Reading a %s file", filetype)
      end,
      -- workspace_text = "Working on ", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
      line_number_text = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
    },
  },
  {
    {
      "akinsho/toggleterm.nvim",
      enabled = true,
      config = true,
      cmd = "ToggleTerm",
      -- keys = { { "<C-/>", "<cmd>ToggleTerm<cr>", desc = "Toggle floating terminal" } },
      opts = {
        -- open_mapping = [[<F4>]],
        direction = "float",
        shade_filetypes = {},
        hide_numbers = true,
        insert_mappings = true,
        terminal_mappings = true,
        start_in_insert = true,
        close_on_exit = true,
      },
    },
  },
  {
    "NoahTheDuke/vim-just",
  },
  {
    "mg979/vim-visual-multi",
  },
  {
    "cordx56/rustowl",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.rustowl.setup({
        trigger = {
          hover = true,
        },
        idle_time = 1000,
      })
    end,
    -- keys = {
    --   { "<C-o>", require("rustowl").rustowl_cursor, desc = "RustOwl" },
    -- },
  },
}
