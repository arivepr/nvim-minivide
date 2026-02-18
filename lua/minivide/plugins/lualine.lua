return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-mini/mini.icons", "ThePrimeagen/harpoon" },
    opts = function()
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
              table.insert(tabs, "%#lualine_a_normal# " .. i .. " " .. name .. " ")
            else
              table.insert(tabs, "%#lualine_b_normal# " .. i .. " " .. name .. " ")
            end
          end
        end

        if #tabs == 0 then return "" end
        return table.concat(tabs)
      end

      return {
      options = {
        icons_enabled = true,
        theme = "auto", -- Will match your colorscheme automatically
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true, -- One statusline for all windows
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } }, -- path = 1 shows relative path
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        lualine_a = { harpoon_tabline },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      winbar = {},
      inactive_winbar = {},
      extensions = { "fzf", "lazy", "mason" },
    }
    end,
  },
}
