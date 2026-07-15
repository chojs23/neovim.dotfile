-- Start Copilot only once a real file is opened, so it never runs on an empty
-- session and never adds its node process to startup.
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("copilot_lazy", { clear = true }),
  once = true,
  callback = function()
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
  end,
})
