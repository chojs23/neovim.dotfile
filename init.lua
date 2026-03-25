require("config.lazy")

-- local function ensure_ts_bridge_daemon()
--   if vim.g.ts_bridge_daemon_started then
--     return
--   end
--   vim.g.ts_bridge_daemon_started = true
--   vim.fn.jobstart({
--     "ts-bridge",
--     "daemon",
--     "--listen",
--     "127.0.0.1:7007",
--     "--idle-ttl",
--     "30m",
--   }, {
--     detach = true,
--     env = { RUST_LOG = "info" },
--   })
-- end
--
-- local function wait_for_daemon(host, port, timeout_ms)
--   local addr = ("%s:%d"):format(host, port)
--   return vim.wait(timeout_ms, function()
--     local ok, chan = pcall(vim.fn.sockconnect, "tcp", addr, { rpc = false })
--     if not ok or type(chan) ~= "number" or chan <= 0 then
--       return false
--     end
--     vim.fn.chanclose(chan)
--     return true
--   end, 50)
-- end
--
-- local function daemon_cmd(dispatchers)
--   ensure_ts_bridge_daemon()
--   wait_for_daemon("127.0.0.1", 7007, 2000)
--   return vim.lsp.rpc.connect("127.0.0.1", 7007)(dispatchers)
-- end
--
-- local function start_ts_bridge(bufnr)
--   local root = vim.fs.root(bufnr, { "tsconfig.json", "jsconfig.json", "package.json", ".git" })
--   if not root then
--     return
--   end
--   for _, client in ipairs(vim.lsp.get_clients({ name = "ts_bridge" })) do
--     local folder = client.workspace_folders and client.workspace_folders[1]
--     if folder and folder.name == root then
--       return -- already running for this workspace
--     end
--   end
--   vim.lsp.start({
--     name = "ts_bridge",
--     cmd = daemon_cmd,
--     root_dir = root,
--     filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
--     settings = { ["ts-bridge"] = { enable_inlay_hints = false } },
--   })
-- end
--
-- vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
--   group = vim.api.nvim_create_augroup("ts_bridge", { clear = true }),
--   pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
--   callback = function(args)
--     start_ts_bridge(args.buf)
--   end,
-- })

local function ensure_ts_bridge_daemon()
  print(vim.inspect(vim.g.ts_bridge_daemon_started))
  if vim.g.ts_bridge_daemon_started then
    return
  end
  vim.g.ts_bridge_daemon_started = true
  vim.fn.jobstart({
    "/Users/neo/Desktop/personal/ts-bridge/target/release/ts-bridge",
    -- "/Users/neo/Desktop/personal/ts-bridge/target/release/ts-bridge",
    "daemon",
    "--listen",
    "127.0.0.1:7007", -- choose your port
    "--idle-ttl",
    "10s",
  }, {
    detach = true,
    env = { RUST_LOG = "info" },
  })
end

local function wait_for_daemon(host, port, timeout_ms)
  local addr = string.format("%s:%d", host, port)
  local function is_ready()
    local ok, chan = pcall(vim.fn.sockconnect, "tcp", addr, { rpc = false })
    if not ok then
      return false
    end
    if type(chan) == "number" and chan > 0 then
      vim.fn.chanclose(chan)
      return true
    end
    return false
  end
  return vim.wait(timeout_ms, is_ready, 50)
end

local function daemon_cmd(dispatchers)
  print("Starting ts-bridge daemon...")
  ensure_ts_bridge_daemon()
  -- Built-in LSP has no `on_new_config`, and `before_init` runs after `cmd`, so
  -- start + wait here to avoid a first-attach connection refusal.
  wait_for_daemon("127.0.0.1", 7007, 500)
  return vim.lsp.rpc.connect("127.0.0.1", 7007)(dispatchers)
end

vim.lsp.config("ts_bridge", {
  cmd = daemon_cmd,
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
  settings = {
    ["ts-bridge"] = {
      separate_diagnostic_server = false,
      enable_inlay_hints = false,
    },
  },
})

vim.lsp.enable("ts_bridge")

vim.api.nvim_create_user_command("TSBridgeStatus", function()
  local client = vim.lsp.get_clients({ bufnr = 0, name = "ts_bridge" })[1]
  if not client then
    vim.notify("ts_bridge not attached to this buffer", vim.log.levels.WARN)
    return
  end
  client.request("ts-bridge/status", {}, function(err, result)
    if err then
      vim.notify(vim.inspect(err), vim.log.levels.ERROR)
      return
    end
    vim.print(result)
  end)
end, {})

-- local lspconfig = require("lspconfig")
-- local configs = require("lspconfig.configs")
--
-- if not configs.ts_ls then
--   configs.ts_ls = {
--     default_config = {
--       cmd = { "/Users/neo/Desktop/personal/ts-bridge/target/release/ts-bridge" },
--       cmd_env = {
--         RUST_LOG = "trace",
--         RUST_BACKTRACE = "1",
--       },
--       filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
--       root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", ".git"),
--     },
--   }
-- end
--
-- lspconfig.ts_ls.setup({})

vim.cmd("set fillchars=eob:~")
