return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function(_, opts)
      require("nvim-treesitter.config").setup(opts)

      -- Enable Treesitter-based folding
      -- This makes folding understand code structure (functions, classes, etc.)
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      -- Ensure folds start open by default so your file isn't collapsed on open
      vim.opt.foldlevel = 99 

      -- Performance "Kill Switch" for large files
      -- Disables Treesitter highlighting on files larger than 500KB to prevent lag
      vim.api.nvim_create_autocmd("BufReadPre", {
        callback = function(ev)
          local max_filesize = 500 * 1024 -- 500 KB
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
          if ok and stats and stats.size > max_filesize then
            vim.b.ts_highlight = false
          end
        end,
      })
    end,
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "gdscript",
        "python",
        "typescript",
        "javascript",
        "html",
        "css",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
  },
}
