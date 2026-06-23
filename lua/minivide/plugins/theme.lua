return {
  {
    "shaunsingh/seoul256.nvim",
    priority = 1000,
    config = function()
      -- Seoul256 configuration
      vim.g.seoul256_italic_comments = true
      vim.g.seoul256_italic_keywords = true
      vim.g.seoul256_contrast = true
      vim.g.seoul256_borders = true
      vim.g.seoul256_cursorline = true

      vim.cmd.colorscheme("seoul256")

      local palette = require("minivide.core.palette")
      local c = palette.get()

      palette.apply_highlights(c)
    end,
  },
}
