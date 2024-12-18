return {
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
      -- tsserver = { -- deprecated
      --   settings = {
      --     typescript = {
      --       inlayHints = {
      --         includeInlayParameterNameHints = "literal",
      --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      --         includeInlayFunctionParameterTypeHints = false,
      --         includeInlayVariableTypeHints = false,
      --         includeInlayPropertyDeclarationTypeHints = false,
      --         includeInlayFunctionLikeReturnTypeHints = true,
      --         includeInlayEnumMemberValueHints = true,
      --       },
      --     },
      --     javascript = {
      --       inlayHints = {
      --         includeInlayParameterNameHints = "all",
      --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      --         includeInlayFunctionParameterTypeHints = true,
      --         includeInlayVariableTypeHints = true,
      --         includeInlayPropertyDeclarationTypeHints = true,
      --         includeInlayFunctionLikeReturnTypeHints = true,
      --         includeInlayEnumMemberValueHints = true,
      --       },
      --     },
      --   },
      -- },
      --   rust_analyzer = {
      --     mason = false,
      --     on_attach = function(bufnr, client)
      --       vim.lsp.inlay_hint.enable(false)
      --     end,
      --     settings = {
      --       ["rust-analyzer"] = {
      --         cargo = {
      --           autoreload = false,
      --         },
      --         procMacro = {
      --           enable = true,
      --         },
      --         inlayHints = {
      --           enable = false,
      --         },
      --       },
      --     },
      --   },
      -- },
    },
    setup = {},
  },
}
