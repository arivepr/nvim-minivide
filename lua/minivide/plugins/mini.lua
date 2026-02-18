return {
  -- Autopairs: auto-close brackets, quotes, etc.
  {
    "nvim-mini/mini.pairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Comment toggling: gcc for line, gc + motion for block
  {
    "nvim-mini/mini.comment",
    event = "VeryLazy",
    opts = {},
  },

  -- Surround: sa (add), sd (delete), sr (replace)
  {
    "nvim-mini/mini.surround",
    event = "VeryLazy",
    opts = {},
  },

  -- Indentscope: animated vertical line for current scope
  {
    "nvim-mini/mini.indentscope",
    event = "VeryLazy",
    opts = {
      symbol = "│",
      options = {
        try_as_border = true,
      },
    },
    init = function()
      -- Disable for filetypes where it doesn't make sense
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "lazy", "mason", "oil", "toggleterm" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
