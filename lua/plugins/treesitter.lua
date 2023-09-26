return {
  {
    "hiphish/rainbow-delimiters.nvim",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = function(_, opts)
      opts.rainbow = { enable = true }
      opts.highlight = { enable = true }
      opts.indent = { enable = true }
      opts.incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      }
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "prisma", "php" })
      end
    end,
  },
  {
    "nvim-treesitter/playground",
  },
}
