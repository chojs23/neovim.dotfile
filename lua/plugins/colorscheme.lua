local group = vim.api.nvim_create_augroup("colorscheme", { clear = true })

local function apply_overrides()
  vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#7d8299", bg = "#262626" })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusModified", { fg = "#FF8800" })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", { fg = "#6BB8FF" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  callback = apply_overrides,
})

vim.cmd.colorscheme("base16-da-one-black")
apply_overrides()
