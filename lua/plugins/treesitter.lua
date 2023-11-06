return {
  {
    "hiphish/rainbow-delimiters.nvim",
    enabled = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    enabled = true,
    opts = function(_, opts)
      opts.rainbow = { max_file_lines = 5000 }
      opts.highlight = {
        enable = true,
        max_file_lines = 10000,
        disable = function(lang, bufnr)
          return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > 1048576
        end,
      }
      opts.indent = { enable = false }
      opts.incremental_selection = {
        enable = false,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      }
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "prisma", "php", "graphql" })
      end
    end,
  },
  {
    "nvim-treesitter/playground",
    enabled = true,
  },
}
