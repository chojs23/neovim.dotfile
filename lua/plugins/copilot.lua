vim.schedule(function()
  require("copilot").setup({
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<C-y>",
        accept_word = false,
        accept_line = false,
        next = "<C-n>",
        prev = "<C-p>",
        dismiss = "<C-]>",
      },
    },
    panel = { enabled = false },
    filetypes = {
      markdown = true,
      help = true,
    },
  })
end)
