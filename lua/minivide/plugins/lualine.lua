return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-mini/mini.icons", "ThePrimeagen/harpoon" },
    opts = function()
      local colors = require("catppuccin.palettes").get_palette()

      local mode_color = {
        n = colors.blue,
        i = colors.green,
        v = colors.mauve,
        [""] = colors.mauve,
        V = colors.mauve,
        c = colors.peach,
        no = colors.red,
        s = colors.flamingo,
        S = colors.flamingo,
        [""] = colors.flamingo,
        ic = colors.yellow,
        R = colors.red,
        Rv = colors.red,
        cv = colors.peach,
        ce = colors.peach,
        r = colors.teal,
        rm = colors.teal,
        ["r?"] = colors.teal,
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

      -- Set up tabline highlight groups using catppuccin colors
      vim.api.nvim_set_hl(0, "MinivideTablActive", { fg = colors.blue, bg = colors.mantle, bold = true })
      vim.api.nvim_set_hl(0, "MinivideTablInactive", { fg = colors.overlay0, bg = colors.mantle })
      vim.api.nvim_set_hl(0, "MinivideTablineBg", { fg = colors.overlay0, bg = colors.mantle })

      local config = {
        options = {
          icons_enabled = true,
          component_separators = "",
          section_separators = "",
          theme = {
            normal = { c = { fg = colors.text, bg = colors.mantle } },
            inactive = { c = { fg = colors.overlay0, bg = colors.mantle } },
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
        color = { fg = colors.subtext0 },
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
        color = { fg = colors.subtext0 },
      })

      -- Progress
      ins_left({
        "progress",
        color = { fg = colors.subtext0 },
      })

      -- Diagnostics
      ins_left({
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " " },
        diagnostics_color = {
          error = { fg = colors.red },
          warn = { fg = colors.yellow },
          info = { fg = colors.sky },
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
        color = { fg = colors.subtext0 },
      })

      -- Right side

      -- Encoding
      ins_right({
        "o:encoding",
        fmt = string.upper,
        cond = conditions.hide_in_width,
        color = { fg = colors.overlay1 },
      })

      -- File format
      ins_right({
        "fileformat",
        fmt = string.upper,
        icons_enabled = false,
        color = { fg = colors.overlay1 },
      })

      -- Git branch
      ins_right({
        "branch",
        icon = "",
        color = { fg = colors.mauve, gui = "bold" },
      })

      -- Git diff
      ins_right({
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.peach },
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
    end,
  },
}
