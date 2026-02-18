return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      { "<leader>G", function() Snacks.lazygit() end, desc = "Lazygit" },
    },
    opts = {
      input = { enabled = true },
      lazygit = { enabled = true },
      styles = {
        input = {
          border = "single",
          wo = { winblend = 0 },
        },
        lazygit = {
          border = "single",
          wo = { winblend = 0 },
        },
      },
    },
  },
}
