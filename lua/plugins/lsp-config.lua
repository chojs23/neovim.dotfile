return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
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
      -- eslint = {},
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
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "literal",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = false,
              includeInlayVariableTypeHints = false,
              includeInlayPropertyDeclarationTypeHints = false,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
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
      -- eslint = function()
      --   require("lazyvim.util").lsp.on_attach(function(client)
      --     if client.name == "eslint" then
      --       client.server_capabilities.documentFormattingProvider = true
      --     elseif client.name == "tsserver" then
      --       client.server_capabilities.documentFormattingProvider = false
      --     end
      --   end)
      -- end,
    },
  },
}
