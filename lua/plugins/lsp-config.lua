return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      update_in_insert = false,
      virtual_text = {
        prefix = "icons",
      },
      severity_sort = true,
    },
    -- capabilities = {
    --   workspace = {
    --     applyEdit = true,
    --     configuration = true,
    --     didChangeWatchedFiles = {
    --       dynamicRegistration = true,
    --       relativePatternSupport = true,
    --     },
    --     didChangeWorkspaceFolders = {
    --       dynamicRegistration = true,
    --     },
    --     inlayHint = {
    --       refreshSupport = true,
    --     },
    --     semanticTokens = vim.NIL,
    --     symbol = {
    --       dynamicRegistration = false,
    --       symbolKind = {
    --         valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 },
    --       },
    --     },
    --     workspaceEdit = {
    --       resourceOperations = { "rename", "create", "delete" },
    --     },
    --     workspaceFolders = true,
    --   },
    -- },
    inlay_hints = {
      enabled = true,
    },
    servers = {
      eslint = {},
      lua_ls = {
        settings = {
          Lua = {
            hint = {
              enable = true,
            },
          },
        },
      },
      tsserver = {
        -- on_attach = function(client, bufnr)
        --   vim.lsp.inlay_hint(bufnr, true)
        -- end,
        settings = {
          typescript = {
            format = {
              indentSize = vim.o.shiftwidth,
              convertTabsToSpaces = vim.o.expandtab,
              tabSize = vim.o.tabstop,
            },
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
          javascript = {
            format = {
              indentSize = vim.o.shiftwidth,
              convertTabsToSpaces = vim.o.expandtab,
              tabSize = vim.o.tabstop,
            },
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
          completion = {
            completeFunctionCalls = true,
          },
        },
      },
      -- rust_analyzer = {
      --   settings = {
      --     ["rust-analyzer"] = {
      --       inlay_hints = {
      --         closureCaptureHints = true,
      --         parameterHints = true,
      --       },
      --     },
      --   },
      -- },
    },
    setup = {
      eslint = function()
        require("lazyvim.util").on_attach(function(client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
    },
  },
}
