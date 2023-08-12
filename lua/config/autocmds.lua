vim.cmd([[
   augroup ColorSchemeOverride
   au!
   au ColorScheme *
   \ highlight! Comment cterm=italic gui=italic guifg=#a3a3a3
\| highlight! Normal guifg=#d6d6d6
\|  highlight! GitSignsCurrentLineBlame cterm=italic gui=italic guifg=#a3a3a3
\|  highlight! Visual guibg=#424242
\|  highlight! LspInlayHint guifg=#474747
\|  highlight! Pmenu guibg=#424242
\|  highlight! PmenuThumb guibg=#bdbbbb
\|  highlight! PmenuSel guibg=#222222
\|  highlight! NeoTreeCursorLine guibg=#303030
\|  highlight! NeoTreeGitIgnored guifg=#7a7a7a
]])
vim.api.nvim_exec_autocmds("ColorScheme", {})

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = function()
    vim.lsp.inlay_hint(0, false)
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function()
    vim.lsp.inlay_hint(0, true)
  end,
})
vim.diagnostic.config({
  update_in_insert = false,
})
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  update_in_insert = false,
})
