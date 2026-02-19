return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      {
        "<leader>L",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>Tr",
        function()
          Snacks.terminal.open(nil, { win = { position = "right", width = 0.25, border = "single" } })
        end,
        desc = "right split",
      },
      {
        "<leader>Tb",
        function()
          Snacks.terminal.open(nil, { win = { position = "bottom", height = 0.25, border = "single" } })
        end,
        desc = "bottom split",
      },
      {
        "<leader>Tf",
        function()
          Snacks.terminal.open(nil, { win = { position = "float", border = "single", width = 0.80, height = 0.85 } })
        end,
        desc = "floating",
      },
    },
    opts = {
      input = { enabled = true },
      lazygit = { enabled = true },
      terminal = {
        enabled = true,
        win = {
          keys = {
            close_n = { "<leader>Tq", "close", mode = "n", desc = "close terminal" },
          },
        },
      },
      styles = {
        input = {
          border = "single",
          wo = { winblend = 0 },
        },
        lazygit = {
          border = "single",
          wo = { winblend = 0 },
        },
        terminal = {
          border = "single",
          wo = { winblend = 0 },
        },
      },
    },
  },
}
