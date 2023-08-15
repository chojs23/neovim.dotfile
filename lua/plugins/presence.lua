return {
  "andweeb/presence.nvim",
  event = "VeryLazy",
  opts = {
    -- General options
    auto_update = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
    neovim_image_text = "ㅇㅅㅇ", -- Text displayed when hovered over the Neovim image
    main_image = "file", -- Main image display (either "neovim" or "file")
    client_id = "793271441293967371", -- Use your own Discord application client id (not recommended)
    log_level = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    enable_line_number = true, -- Displays the current line number instead of the current project
    blacklist = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    buttons = false, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
    file_assets = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
    show_time = true, -- Show the timer

    -- Rich Presence text options
    editing_text = function(filename) -- filename arg doesn't need to be used here
      -- Determine type of file using vim's &filetype variable
      local filetype = vim.bo.filetype:gsub("^%l", string.upper)
      return string.format("Editing a %s file", filetype)
    end,
    file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
    git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
    plugin_manager_text = "Managing %s", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
    reading_text = function(filename) -- filename arg doesn't need to be used here
      -- Determine type of file using vim's &filetype variable
      local filetype = vim.bo.filetype:gsub("^%l", string.upper)
      return string.format("Reading a %s file", filetype)
    end,
    -- workspace_text = "Working on ", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
    line_number_text = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
  },
}
