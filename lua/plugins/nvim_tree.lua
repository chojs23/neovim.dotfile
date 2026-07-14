require("nvim-tree").setup({
  view = {
    width = 25,
  },
  renderer = {
    special_files = {},
    group_empty = true,
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
  git = {
    enable = true,
    show_on_dirs = true,
  },
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
})
