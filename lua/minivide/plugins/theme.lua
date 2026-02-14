return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Load this first
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = false,
        term_colors = true,
        integrations = {
          cmp = true,
          fzf = true,
          gitsigns = true,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
          telescope = {
            enabled = true,
          },
          treesitter = true,
          which_key = true,
        },
      })

      -- setup must be called before loading
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
