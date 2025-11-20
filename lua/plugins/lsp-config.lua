return {
  {
    "neovim/nvim-lspconfig",
    -- event = { "BufReadPre", "BufNewFile" },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          prefix = "icons",
        },
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
        },
      },
      inlay_hints = {
        enabled = false,
      },
      servers = {
        eslint = {
          enabled = true,
          settings = {
            codeAction = {
              disableRuleComment = {
                enable = true,
                location = "separateLine",
              },
              showDocumentation = {
                enable = false,
              },
            },
            codeActionOnSave = {
              enable = false,
              mode = "all",
            },
            format = false,
            quiet = true,
            run = "onSave",
          },
        },
        tsgo = {
          enabled = false,
        },
      },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    enabled = true,
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      settings = {
        separate_diagnostic_server = false,
        tsserver_max_memory = "auto",
      },
    },
    keys = {
      { "<leader>co", "<cmd>TSToolsOrganizeImports<cr>", desc = "Organize Imports" },
    },
  },
}
