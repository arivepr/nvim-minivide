return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-mini/mini.icons", "ThePrimeagen/harpoon" },
    opts = function()
      local palette = require("minivide.core.palette")
      local c = palette.get()

      -- Set up tabline highlight groups
      palette.apply_tabline(c)

      return require("minivide.core.lualine_config")(c)
    end,
  },
}
