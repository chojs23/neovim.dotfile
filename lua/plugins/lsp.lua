local diagnostic_icons = {
  [vim.diagnostic.severity.ERROR] = " ",
  [vim.diagnostic.severity.WARN] = " ",
  [vim.diagnostic.severity.INFO] = " ",
  [vim.diagnostic.severity.HINT] = " ",
}

vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    prefix = function(diagnostic)
      return diagnostic_icons[diagnostic.severity] or "● "
    end,
  },
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
})

local servers = {
  bashls = {},
  dockerls = {},
  gopls = {
    settings = {
      gopls = {
        analyses = {
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        completeUnimported = true,
        gofumpt = true,
        staticcheck = true,
        usePlaceholders = true,
      },
    },
  },
  jsonls = {},
  lua_ls = {
    settings = {
      Lua = {
        codeLens = { enable = true },
        completion = { callSnippet = "Replace" },
        hint = {
          enable = true,
          arrayIndex = "Disable",
          paramName = "Disable",
          semicolon = "Disable",
        },
        runtime = { version = "LuaJIT" },
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME },
        },
      },
    },
  },
  marksman = {},
  pyright = {},
  ruff = {},
  tsgo = {},
  eslint = {},
  yamlls = {},
}

vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })

for name, config in pairs(servers) do
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end

-- Rustaceanvim owns the rust-analyzer client, while Mason only provides its executable.
local mason_servers = vim.list_extend(vim.tbl_keys(servers), {})
table.sort(mason_servers)
require("mason-lspconfig").setup({
  ensure_installed = mason_servers,
  automatic_enable = false,
})

local function map(buffer, lhs, rhs, description)
  vim.keymap.set("n", lhs, rhs, { buffer = buffer, silent = true, desc = description })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
  callback = function(event)
    map(event.buf, "gd", function()
      require("telescope.builtin").lsp_definitions({ reuse_win = true })
    end, "Go to definition")
    map(event.buf, "gr", "<cmd>Telescope lsp_references<cr>", "References")
    map(event.buf, "gI", function()
      require("telescope.builtin").lsp_implementations({ reuse_win = true })
    end, "Go to implementation")
    map(event.buf, "gy", function()
      require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
    end, "Go to type definition")
    map(event.buf, "gD", vim.lsp.buf.declaration, "Go to declaration")
    map(event.buf, "K", vim.lsp.buf.hover, "Hover")
    map(event.buf, "gK", vim.lsp.buf.signature_help, "Signature help")
    map(event.buf, "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map(event.buf, "<leader>cr", vim.lsp.buf.rename, "Rename")
  end,
})

local function diagnostic_jump(count, severity)
  return function()
    vim.diagnostic.jump({ count = count * vim.v.count1, severity = severity, float = true })
  end
end

vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
vim.keymap.set("n", "]d", diagnostic_jump(1), { desc = "Next diagnostic" })
vim.keymap.set("n", "[d", diagnostic_jump(-1), { desc = "Previous diagnostic" })
vim.keymap.set("n", "]e", diagnostic_jump(1, vim.diagnostic.severity.ERROR), { desc = "Next error" })
vim.keymap.set("n", "[e", diagnostic_jump(-1, vim.diagnostic.severity.ERROR), { desc = "Previous error" })
vim.keymap.set("n", "]w", diagnostic_jump(1, vim.diagnostic.severity.WARN), { desc = "Next warning" })
vim.keymap.set("n", "[w", diagnostic_jump(-1, vim.diagnostic.severity.WARN), { desc = "Previous warning" })
