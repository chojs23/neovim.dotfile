return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    rainbow = { enable = true },
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },
}
