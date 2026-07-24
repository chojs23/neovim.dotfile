-- ==============================================================================
-- mini.nvim
-- ==============================================================================

local snacks = require("snacks")

local function buffer_textobject(ai_type)
  local start_line, end_line = 1, vim.fn.line("$")
  if ai_type == "i" then
    local first_nonblank = vim.fn.nextnonblank(start_line)
    local last_nonblank = vim.fn.prevnonblank(end_line)
    if first_nonblank == 0 or last_nonblank == 0 then
      return { from = { line = start_line, col = 1 } }
    end
    start_line, end_line = first_nonblank, last_nonblank
  end

  local end_column = math.max(vim.fn.getline(end_line):len(), 1)
  return { from = { line = start_line, col = 1 }, to = { line = end_line, col = end_column } }
end

local ai = require("mini.ai")
ai.setup({
  n_lines = 500,
  custom_textobjects = {
    o = ai.gen_spec.treesitter({
      a = { "@block.outer", "@conditional.outer", "@loop.outer" },
      i = { "@block.inner", "@conditional.inner", "@loop.inner" },
    }),
    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
    d = { "%f[%d]%d+" },
    e = {
      { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
      "^().*()$",
    },
    g = buffer_textobject,
    u = ai.gen_spec.function_call(),
    U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }),
  },
})

require("mini.icons").setup({
  file = {
    [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
    ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
  },
  filetype = {
    dotenv = { glyph = "", hl = "MiniIconsYellow" },
  },
})
package.preload["nvim-web-devicons"] = function()
  require("mini.icons").mock_nvim_web_devicons()
  return package.loaded["nvim-web-devicons"]
end

local pair_options = {
  modes = { insert = true, command = true, terminal = false },
  mappings = {
    ["'"] = false,
    ['"'] = false,
    ["`"] = false,
  },
  skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
  skip_ts = { "string" },
  skip_unbalanced = true,
  markdown = true,
}

local mini_pairs = require("mini.pairs")
mini_pairs.setup(pair_options)

local open_pair = mini_pairs.open
mini_pairs.open = function(pair, neighborhood)
  if vim.fn.getcmdline() ~= "" then
    return open_pair(pair, neighborhood)
  end

  local opening, closing = pair:sub(1, 1), pair:sub(2, 2)
  local line = vim.api.nvim_get_current_line()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local next_character = line:sub(cursor[2] + 1, cursor[2] + 1)
  local before_cursor = line:sub(1, cursor[2])

  if pair_options.markdown and opening == "`" and vim.bo.filetype == "markdown" and before_cursor:match("^%s*``") then
    return "`\n```" .. vim.keycode("<Up>")
  end
  if pair_options.skip_next and next_character ~= "" and next_character:match(pair_options.skip_next) then
    return opening
  end
  if pair_options.skip_ts and #pair_options.skip_ts > 0 then
    local ok, captures = pcall(vim.treesitter.get_captures_at_pos, 0, cursor[1] - 1, math.max(cursor[2] - 1, 0))
    for _, capture in ipairs(ok and captures or {}) do
      if vim.tbl_contains(pair_options.skip_ts, capture.capture) then
        return opening
      end
    end
  end
  if pair_options.skip_unbalanced and next_character == closing and closing ~= opening then
    local _, opening_count = line:gsub(vim.pesc(opening), "")
    local _, closing_count = line:gsub(vim.pesc(closing), "")
    if closing_count > opening_count then
      return opening
    end
  end
  return open_pair(pair, neighborhood)
end

snacks
    .toggle({
      name = "Mini Pairs",
      get = function()
        return not vim.g.minipairs_disable
      end,
      set = function(enabled)
        vim.g.minipairs_disable = not enabled
      end,
    })
    :map("<leader>up")

require("mini.surround").setup({
  mappings = {
    add = "gsa",
    delete = "gsd",
    find = "gsf",
    find_left = "gsF",
    highlight = "gsh",
    replace = "gsr",
    update_n_lines = "gsn",
  },
})

local hipatterns = require("mini.hipatterns")
local shades = { 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950 }
local palette_values = {
  slate = "f8fafc f1f5f9 e2e8f0 cbd5e1 94a3b8 64748b 475569 334155 1e293b 0f172a 020617",
  gray = "f9fafb f3f4f6 e5e7eb d1d5db 9ca3af 6b7280 4b5563 374151 1f2937 111827 030712",
  zinc = "fafafa f4f4f5 e4e4e7 d4d4d8 a1a1aa 71717a 52525b 3f3f46 27272a 18181b 09090b",
  neutral = "fafafa f5f5f5 e5e5e5 d4d4d4 a3a3a3 737373 525252 404040 262626 171717 0a0a0a",
  stone = "fafaf9 f5f5f4 e7e5e4 d6d3d1 a8a29e 78716c 57534e 44403c 292524 1c1917 0a0a0a",
  red = "fef2f2 fee2e2 fecaca fca5a5 f87171 ef4444 dc2626 b91c1c 991b1b 7f1d1d 450a0a",
  orange = "fff7ed ffedd5 fed7aa fdba74 fb923c f97316 ea580c c2410c 9a3412 7c2d12 431407",
  amber = "fffbeb fef3c7 fde68a fcd34d fbbf24 f59e0b d97706 b45309 92400e 78350f 451a03",
  yellow = "fefce8 fef9c3 fef08a fde047 facc15 eab308 ca8a04 a16207 854d0e 713f12 422006",
  lime = "f7fee7 ecfccb d9f99d bef264 a3e635 84cc16 65a30d 4d7c0f 3f6212 365314 1a2e05",
  green = "f0fdf4 dcfce7 bbf7d0 86efac 4ade80 22c55e 16a34a 15803d 166534 14532d 052e16",
  emerald = "ecfdf5 d1fae5 a7f3d0 6ee7b7 34d399 10b981 059669 047857 065f46 064e3b 022c22",
  teal = "f0fdfa ccfbf1 99f6e4 5eead4 2dd4bf 14b8a6 0d9488 0f766e 115e59 134e4a 042f2e",
  cyan = "ecfeff cffafe a5f3fc 67e8f9 22d3ee 06b6d4 0891b2 0e7490 155e75 164e63 083344",
  sky = "f0f9ff e0f2fe bae6fd 7dd3fc 38bdf8 0ea5e9 0284c7 0369a1 075985 0c4a6e 082f49",
  blue = "eff6ff dbeafe bfdbfe 93c5fd 60a5fa 3b82f6 2563eb 1d4ed8 1e40af 1e3a8a 172554",
  indigo = "eef2ff e0e7ff c7d2fe a5b4fc 818cf8 6366f1 4f46e5 4338ca 3730a3 312e81 1e1b4b",
  violet = "f5f3ff ede9fe ddd6fe c4b5fd a78bfa 8b5cf6 7c3aed 6d28d9 5b21b6 4c1d95 2e1065",
  purple = "faf5ff f3e8ff e9d5ff d8b4fe c084fc a855f7 9333ea 7e22ce 6b21a8 581c87 3b0764",
  fuchsia = "fdf4ff fae8ff f5d0fe f0abfc e879f9 d946ef c026d3 a21caf 86198f 701a75 4a044e",
  pink = "fdf2f8 fce7f3 fbcfe8 f9a8d4 f472b6 ec4899 db2777 be185d 9d174d 831843 500724",
  rose = "fff1f2 ffe4e6 fecdd3 fda4af fb7185 f43f5e e11d48 be123c 9f1239 881337 4c0519",
}

local palettes = {}
for name, values in pairs(palette_values) do
  palettes[name] = {}
  for index, color in ipairs(vim.split(values, " ")) do
    palettes[name][shades[index]] = color
  end
end

local tailwind_highlights = {}
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("mini_hipatterns", { clear = true }),
  callback = function()
    tailwind_highlights = {}
  end,
})

hipatterns.setup({
  highlighters = {
    hex_color = hipatterns.gen_highlighter.hex_color({ priority = 2000 }),
    shorthand = {
      pattern = "()#%x%x%x()%f[^%x%w]",
      group = function(_, _, data)
        if data.full_match == "#add" then
          return
        end
        local red, green, blue = data.full_match:sub(2, 2), data.full_match:sub(3, 3), data.full_match:sub(4, 4)
        return hipatterns.compute_hex_color_group("#" .. red .. red .. green .. green .. blue .. blue, "bg")
      end,
      extmark_opts = { priority = 2000 },
    },
    tailwind = {
      pattern = function()
        local filetypes = {
          "astro",
          "css",
          "heex",
          "html",
          "html-eex",
          "javascript",
          "javascriptreact",
          "rust",
          "svelte",
          "typescript",
          "typescriptreact",
          "vue",
        }
        if vim.tbl_contains(filetypes, vim.bo.filetype) then
          return "%f[%w:-]()[%w:-]+%-[a-z%-]+%-%d+()%f[^%w:-]"
        end
      end,
      group = function(_, _, match)
        local color, shade = match.full_match:match("[%w-]+%-([a-z%-]+)%-(%d+)")
        shade = tonumber(shade)
        local background = vim.tbl_get(palettes, color, shade)
        if not background then
          return
        end

        local highlight = "MiniHipatternsTailwind" .. color .. shade
        if not tailwind_highlights[highlight] then
          tailwind_highlights[highlight] = true
          local foreground_shade = shade == 500 and 950 or shade < 500 and 900 or 100
          local foreground = vim.tbl_get(palettes, color, foreground_shade)
          vim.api.nvim_set_hl(0, highlight, { bg = "#" .. background, fg = "#" .. foreground })
        end
        return highlight
      end,
      extmark_opts = { priority = 2000 },
    },
  },
})

-- ==============================================================================
-- snacks.nvim
-- ==============================================================================

vim.g.snacks_animate = false
require("snacks").setup({
  indent = {
    enabled = true,
    chunk = {
      enabled = true,
      only_current = false,
      priority = 200,
      hl = "SnacksIndentChunk",
      char = {
        corner_top = "┌",
        corner_bottom = "└",
        horizontal = "─",
        vertical = "│",
        arrow = ">",
      },
    },
  },
  notifier = {
    enabled = true,
    top_down = false,
  },
  picker = {
    enabled = true,
  },
})
