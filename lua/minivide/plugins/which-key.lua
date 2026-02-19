return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-mini/mini.icons" },
    opts = {
      delay = 0,
      preset = "classic", -- Fixed UI at the bottom
      win = {
        border = "single", -- Unified with FZF and LSP windows
        padding = { 1, 2 }, -- Add some "breathing room" (top/bottom, left/right)
        title = " Keymaps ",
        title_pos = "center",
      },
      icons = {
        plugin = "mini.icons", -- Uses your high-performance icon provider
      },
      -- Logic to group your leader keys into "folders" in the UI
      spec = {
        -- Uppercase keys (displayed first)
        { "<leader>F", group = "flutter", icon = " " }, -- Multiple files icon
        { "<leader>f", group = "find", icon = " " }, -- Search icon
        { "<leader>l", group = "lsp", icon = " " }, -- Package/Box icon
        { "<leader>d", group = "debug", icon = " " }, -- Debug icon
        { "<leader>h", group = "harpoon", icon = "󱡅 " },
        { "<leader>b", group = "buffer", icon = " " },
        { "<leader>F", group = "flutter", icon = "" },
        { "<leader>g", group = "godot", icon = " " }, -- Godot icon
        { "<leader>T", group = "terminal", icon = "" },
        { "<leader>S", group = "session", icon = " " },
        { "<leader>w", desc = "save file", icon = " " }, -- Floppy disk icon
      },
    },
  },
}
