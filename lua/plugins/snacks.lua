vim.g.snacks_animate = false
require("snacks").setup({
  explorer = {
    enabled = true,
    replace_netrw = true,
  },
  indent = {
    enabled = true,
    chunk = {
      enabled = true,
      only_current = false,
      priority = 200,
      hl = "SnacksIndentChunk",
      char = {
        corner_top = "┌",
        corner_bottom = "└",
        horizontal = "─",
        vertical = "│",
        arrow = ">",
      },
    },
  },
  notifier = {
    enabled = true,
    top_down = false,
  },
  picker = {
    enabled = true,
    sources = {
      explorer = {
        hidden = true,
        ignored = true,
        layout = {
          hidden = { "input" },
          layout = { width = 25 },
        },
      },
    },
  },
})
