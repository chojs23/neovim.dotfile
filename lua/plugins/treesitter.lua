return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      rainbow = { enable = true },
      opts = function(_, opts)
        opts.ignore_install = { "help" }
        opts.sync_install = false

        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, {
            "git_config",
            "jsdoc",
            "vimdoc",
            "prisma",
          })
        end
      end,
    },
  },
  {
    "nvim-treesitter/playground",
  },
}
