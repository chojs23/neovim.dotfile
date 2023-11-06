return {
  dir = "utils/term",
  event = "VeryLazy",
  keys = {
    {
      "<leader>gb",
      "<cmd>Bottom<CR>",
      -- "<cmd>lua require('utils.term').system_info_toggle()<CR>",
      "System info",
      { desc = "Toggle sysinfo", noremap = true, silent = true, mode = "n" },
    },
  },
}
