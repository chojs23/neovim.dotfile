require("blink.cmp").setup({
  keymap = { preset = "enter" },
  completion = {
    documentation = { auto_show = true },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  -- Falls back to the Lua matcher if the prebuilt Rust binary is unavailable.
  fuzzy = { implementation = "prefer_rust_with_warning" },
  signature = { enabled = true },
})
