return {
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("flutter-tools").setup({
        lsp = {
          capabilities = require("blink.cmp").get_lsp_capabilities(),
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
          },
        },
        widget_guides = { enabled = true },
        closing_tags = { enabled = true },
        dev_tools = {
          autostart = true,
          auto_open_browser = false,
        },
        debugger = {
          enabled = true,
          run_via_dap = true,
        },
      })

      vim.keymap.set("n", "<leader>Fr", "<cmd>FlutterRun<cr>", { desc = "run" })
      vim.keymap.set("n", "<leader>Fq", "<cmd>FlutterQuit<cr>", { desc = "quit" })
      vim.keymap.set("n", "<leader>Fl", "<cmd>FlutterReload<cr>", { desc = "hot reload" })
      vim.keymap.set("n", "<leader>FR", "<cmd>FlutterRestart<cr>", { desc = "hot restart" })
      vim.keymap.set("n", "<leader>Fd", "<cmd>FlutterDevices<cr>", { desc = "devices" })
      vim.keymap.set("n", "<leader>Fe", "<cmd>FlutterEmulators<cr>", { desc = "emulators" })
      vim.keymap.set("n", "<leader>Fo", "<cmd>FlutterOutlineToggle<cr>", { desc = "widget outline" })
      vim.keymap.set("n", "<leader>Ft", "<cmd>FlutterDevTools<cr>", { desc = "dev tools" })
      vim.keymap.set("n", "<leader>Fs", "<cmd>FlutterLspRestart<cr>", { desc = "restart LSP" })
    end,
  },
}
