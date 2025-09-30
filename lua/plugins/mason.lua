return {
  "mason-org/mason.nvim",
  opts = function(_, opts)
    opts.ui = {
      border = "rounded",
    }
    table.insert(opts.ensure_installed, "prettierd")
    table.insert(opts.ensure_installed, "eslint_d")
  end,
}
