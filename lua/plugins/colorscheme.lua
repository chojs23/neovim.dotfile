local group = vim.api.nvim_create_augroup("colorscheme", { clear = true })

local function apply_overrides()
  vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#7d8299", bg = "#262626" })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusModified", { fg = "#FF8800" })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", { fg = "#6BB8FF" })

  -- nvim-tree git status: same palette as the Snacks picker groups above
  local nvim_tree_git = {
    Dirty = "#FF8800",
    New = "#6BB8FF",
  }
  for status, color in pairs(nvim_tree_git) do
    vim.api.nvim_set_hl(0, "NvimTreeGit" .. status .. "Icon", { fg = color })
    vim.api.nvim_set_hl(0, "NvimTreeGitFile" .. status .. "HL", { fg = color })
    vim.api.nvim_set_hl(0, "NvimTreeGitFolder" .. status .. "HL", { fg = color })
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  callback = apply_overrides,
})

vim.cmd.colorscheme("base16-da-one-black")
apply_overrides()
