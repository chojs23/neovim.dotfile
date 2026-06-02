return {
  "chojs23/im-switch.nvim",
  event = "VeryLazy",
  build = "make build",
  config = function()
    require("im-switch").setup({
      auto_capslock_off = true,
    })
  end,
}
