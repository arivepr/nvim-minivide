return {
  {
    "teatek/gdscript-extended-lsp.nvim",
    opts = {
      view_type = "floating",
      floating_win_size = 0.8,
      picker = "fzf-lua", -- We use fzf-lua in this config
    },
    config = function(_, opts)
      require("gdscript-extended-lsp").setup(opts)
      
      -- Keymap for documentation search
      vim.keymap.set("n", "<leader>gh", "<cmd>GodotDoc<cr>", { desc = "Godot: Search Documentation" })
    end,
  },
}
