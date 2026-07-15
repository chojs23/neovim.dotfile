vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("crates_nvim", { clear = true }),
  pattern = "Cargo.toml",
  once = true,
  callback = function()
    require("crates").setup({
      max_parallel_requests = 8,
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    })
  end,
})
