return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        prefix = "icons",
      },
      severity_sort = true,
    },
    -- capabilities = {
    --   textDocument = {
    --     completion = {
    --       editsNearCursor = true,
    --     },
    --   },
    --   general = {
    --     positionEncodings = { "utf-16" },
    --   },
    --   offsetEncoding = { "utf-16" },
    -- },
    -- flags = {
    --   allow_incremental_sync = false,
    --   debounce_text_changes = 500,
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
      dockerls = {},
      docker_compose_language_service = {},
      tsserver = {
        on_attach = function(client, bufnr)
          vim.lsp.inlay_hint(bufnr, true)
        end,
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
      rust_analyzer = {
        on_attach = function(client, bufnr)
          vim.lsp.inlay_hint(bufnr, false)
        end,
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              autoreload = false,
            },
          },
        },
      },
    },
    setup = {
      eslint = function()
        require("lazyvim.util").lsp.on_attach(function(client)
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
