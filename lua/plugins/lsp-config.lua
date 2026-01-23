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
        enabled = true,
      },
      servers = {
        ts_ls = {
          enabled = false,
        },
        biome = {
          enabled = false,
          filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
          settings = {
            biome = {
              format = {
                enable = false,
              },
            },
          },
        },
        eslint = {
          enabled = false,
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
    enabled = false,
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      settings = {
        separate_diagnostic_server = false,
        tsserver_max_memory = "auto",
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeCompletionsForModuleExports = true,
          quotePreference = "auto",
          allowImportingTsExtensions = true,
        },
        tsserver_format_options = {
          allowIncompleteCompletions = false,
          allowRenameOfImportPath = true,
        },
      },
    },
    keys = {
      { "<leader>co", "<cmd>TSToolsOrganizeImports<cr>", desc = "Organize Imports" },
    },
  },
}
