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
      servers = {},
      setup = {},
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        tsserver_max_memory = 4096,
      },
    },
  },
}
