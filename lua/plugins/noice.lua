require("noice").setup({
  cmdline = {
    enabled = true,
    view = "cmdline",
  },
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
    hover = {
      silent = false,
    },
    signature = {
      auto_open = {
        enabled = false,
      },
    },
  },
  messages = {
    enabled = true,
    view = "notify",
    view_error = "notify",
    view_warn = "notify",
    view_history = "messages",
    view_search = "virtualtext",
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
        },
      },
      view = "mini",
    },
  },
  presets = {
    bottom_search = true,
    command_palette = false,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = true,
  },
  views = {
    notify = {
      replace = true,
    },
    mini = {
      position = {
        row = -1,
        col = 0,
      },
    },
  },
})

vim.keymap.set("c", "<S-Enter>", function()
  require("noice").redirect(vim.fn.getcmdline())
end, { desc = "Redirect Cmdline" })

vim.keymap.set("n", "<leader>snl", function()
  require("noice").cmd("last")
end, { desc = "Noice last message" })

vim.keymap.set("n", "<leader>snh", function()
  require("noice").cmd("history")
end, { desc = "Noice history" })

vim.keymap.set("n", "<leader>sna", function()
  require("noice").cmd("all")
end, { desc = "Noice all messages" })

vim.keymap.set("n", "<leader>snd", function()
  require("noice").cmd("dismiss")
end, { desc = "Dismiss all messages" })

vim.keymap.set("n", "<leader>snt", function()
  require("noice").cmd("pick")
end, { desc = "Noice history picker" })

vim.keymap.set({ "i", "n", "s" }, "<C-f>", function()
  if not require("noice.lsp").scroll(4) then
    return "<C-f>"
  end
end, { silent = true, expr = true, desc = "Scroll forward" })

vim.keymap.set({ "i", "n", "s" }, "<C-b>", function()
  if not require("noice.lsp").scroll(-4) then
    return "<C-b>"
  end
end, { silent = true, expr = true, desc = "Scroll backward" })
