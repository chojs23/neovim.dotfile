local M = {}

M.languages = {
  "bash",
  "dockerfile",
  "go",
  "gomod",
  "gosum",
  "gowork",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "prisma",
  "python",
  "regex",
  "tsx",
  "typescript",
  "vim",
  "yaml",
}

local treesitter = require("nvim-treesitter")

local function missing_languages()
  local installed = {}
  for _, language in ipairs(treesitter.get_installed()) do
    installed[language] = true
  end

  return vim.tbl_filter(function(language)
    return not installed[language]
  end, M.languages)
end

function M.install_missing()
  local missing = missing_languages()
  if #missing == 0 then
    return nil
  end

  return treesitter.install(missing, { summary = true })
end

M.install_task = M.install_missing()

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
  callback = function(event)
    local filetype = vim.bo[event.buf].filetype
    local language = vim.treesitter.language.get_lang(filetype) or filetype
    if not vim.treesitter.language.add(language) then
      return
    end

    if not pcall(vim.treesitter.start, event.buf, language) then
      return
    end

    for _, window in ipairs(vim.fn.win_findbuf(event.buf)) do
      vim.wo[window].foldmethod = "expr"
      vim.wo[window].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
  end,
})

return M
