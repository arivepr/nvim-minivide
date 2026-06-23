-- Builds and returns a lualine config table for the given palette colors.
-- Called by lualine.lua on initial setup and by palette.lua on toggle.
return function(colors)
  local mode_color = {
    n = colors.blue,
    i = colors.green,
    v = colors.purple,
    [""] = colors.purple,
    V = colors.purple,
    c = colors.yellow,
    no = colors.red,
    s = colors.accent,
    S = colors.accent,
    [""] = colors.accent,
    ic = colors.yellow,
    R = colors.red,
    Rv = colors.red,
    cv = colors.yellow,
    ce = colors.yellow,
    r = colors.blue,
    rm = colors.blue,
    ["r?"] = colors.blue,
    ["!"] = colors.red,
    t = colors.red,
  }

  local conditions = {
    buffer_not_empty = function() return vim.fn.empty(vim.fn.expand("%:t")) ~= 1 end,
    hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
    check_git_workspace = function()
      local filepath = vim.fn.expand("%:p:h")
      local gitdir = vim.fn.finddir(".git", filepath .. ";")
      return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
  }

  local function harpoon_tabline()
    local ok, harpoon = pcall(require, "harpoon")
    if not ok then return "" end

    local list = harpoon:list()
    local current = vim.api.nvim_buf_get_name(0)
    local tabs = {}

    for i = 1, list:length() do
      local item = list:get(i)
      if item and item.value then
        local name = vim.fn.fnamemodify(item.value, ":t")
        local is_active = current:sub(-#item.value) == item.value
        if is_active then
          table.insert(tabs, "%#MinivideTablActive# " .. i .. " " .. name .. " %*")
        else
          table.insert(tabs, "%#MinivideTablInactive# " .. i .. " " .. name .. " %*")
        end
      end
    end

    if #tabs == 0 then return "" end
    return table.concat(tabs)
  end

  local config = {
    options = {
      icons_enabled = true,
      component_separators = "",
      section_separators = "",
      theme = {
        normal = { c = { fg = colors.fg, bg = colors.statusline_bg } },
        inactive = { c = { fg = colors.disabled, bg = colors.statusline_bg } },
      },
      globalstatus = true,
      refresh = {
        statusline = 100,
        tabline = 100,
      },
    },
    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { harpoon_tabline },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    winbar = {},
    inactive_winbar = {},
    extensions = { "fzf", "lazy", "mason" },
  }

  local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
  end

  local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
  end

  -- Left edge
  ins_left({
    function() return "▊" end,
    color = function() return { fg = mode_color[vim.fn.mode()] } end,
    padding = { left = 0, right = 1 },
  })

  -- Mode indicator
  ins_left({
    function() return "" end,
    color = function() return { fg = mode_color[vim.fn.mode()] } end,
    padding = { right = 1 },
  })

  -- File size
  ins_left({
    "filesize",
    cond = conditions.buffer_not_empty,
    color = { fg = colors.line_numbers },
  })

  -- Filename
  ins_left({
    "filename",
    path = 1,
    cond = conditions.buffer_not_empty,
    color = { fg = colors.blue, gui = "bold" },
  })

  -- Location
  ins_left({
    "location",
    color = { fg = colors.line_numbers },
  })

  -- Progress
  ins_left({
    "progress",
    color = { fg = colors.line_numbers },
  })

  -- Diagnostics
  ins_left({
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " " },
    diagnostics_color = {
      error = { fg = colors.red },
      warn = { fg = colors.yellow },
      info = { fg = colors.blue },
    },
  })

  -- Center divider
  ins_left({ function() return "%=" end })

  -- LSP server name
  ins_left({
    function()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if next(clients) == nil then return "No LSP" end
      local names = {}
      for _, client in ipairs(clients) do
        table.insert(names, client.name)
      end
      return table.concat(names, ", ")
    end,
    icon = " ",
    color = { fg = colors.line_numbers },
  })

  -- Right side

  -- Encoding
  ins_right({
    "o:encoding",
    fmt = string.upper,
    cond = conditions.hide_in_width,
    color = { fg = colors.line_numbers },
  })

  -- File format
  ins_right({
    "fileformat",
    fmt = string.upper,
    icons_enabled = false,
    color = { fg = colors.line_numbers },
  })

  -- Git blame (current line)
  ins_right({
    function()
      local ok, _ = pcall(require, "gitsigns")
      if not ok then return "" end
      local blame = vim.b.gitsigns_blame_line_dict
      if not blame or blame.author == "Not Committed Yet" then return "" end
      local author = blame.author or ""
      local time = blame.author_time_relative or ""
      return author .. ", " .. time
    end,
    cond = conditions.hide_in_width,
    icon = "",
    color = { fg = colors.line_numbers, gui = "italic" },
  })

  -- Git branch
  ins_right({
    "branch",
    icon = "",
    color = { fg = colors.purple, gui = "bold" },
  })

  -- Git diff
  ins_right({
    "diff",
    symbols = { added = " ", modified = " ", removed = " " },
    diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.yellow },
      removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
  })

  -- Right edge
  ins_right({
    function() return "▊" end,
    color = function() return { fg = mode_color[vim.fn.mode()] } end,
    padding = { left = 1 },
  })

  return config
end
