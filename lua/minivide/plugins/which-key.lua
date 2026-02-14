return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      preset = "classic", -- Fixed UI at the bottom
      win = {
        border = "single", -- Unified with FZF and LSP windows
        padding = { 1, 2 }, -- Add some "breathing room" (top/bottom, left/right)
        title = " Minivide Keys ",
        title_pos = "center",
      },
      icons = {
        plugin = "mini.icons", -- Uses your high-performance icon provider
      },
      -- Logic to group your leader keys into "folders" in the UI
      spec = {
        { "<leader>f", group = "find", icon = " " },
        { "<leader>l", group = "lsp", icon = " " },
        { "<leader>w", desc = "save file", icon = "󰆓 " },
      },
    },
  },
}
