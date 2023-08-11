return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        -- hide_by_name = {
        --   ".git",
        -- },
        never_show = {
          ".git",
        },
      },
    },
    window = {
      position = "left",
      width = 30,
      mappings = {
        ["<space>"] = "none",
      },
    },
  },
}
