return {
  "crnvl96/lazydocker.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>gd", "<cmd>LazyDocker<CR>", { desc = "Toggle LazyDocker", noremap = true, silent = true, mode = "n" } },
  },
  opts = {
    popup_window = {
      enter = true,
      focusable = true,
      zindex = 40,
      position = "50%",
      relative = "editor",
      size = {
        width = "90%",
        height = "90%",
      },
      buf_options = {
        modifiable = true,
        readonly = false,
      },
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        winblend = 0,
      },
      border = {
        highlight = "FloatBorder",
        style = "rounded",
        text = {
          top = " Lazydocker ",
        },
      },
    },
  }, -- automatically calls `require("lazydocker").setup()`
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
}
