return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function(_, opts)
      -- In the new nvim-treesitter (v1.0+), setup only handles parser installation.
      -- highlight/indent options are NOT processed by this API.
      require("nvim-treesitter").setup(opts)

      -- Activate treesitter highlighting for all filetypes with an available parser.
      -- This replaces the old highlight = { enable = true } behavior.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      -- Enable Treesitter-based folding
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt.foldlevel = 99
    end,
    opts = {
      -- A list of parser names, or "all"
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "gdscript",
        "godot_resource",
        "gdshader",
        "python",
        "typescript",
        "javascript",
        "html",
        "css",
      },
      -- Highlighting is enabled by default in v1.0, 
      -- but we can still customize it here
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
  },
}
