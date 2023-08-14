return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      rainbow = { enable = true },
      -- highlight = { enable = false },
      opts = function(_, opts)
        -- add tsx and treesitter
        vim.list_extend(opts.ensure_installed, {
          "tsx",
          "typescript",
          "javascript",
        })
      end,
    },
  },
  {
    "nvim-treesitter/playground",
  },
}
