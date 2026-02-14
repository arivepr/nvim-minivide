return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- 1. Setup Mason to manage external binaries
      require("mason").setup()

      -- 2. Setup Mason-LSPConfig with the 0.11-style handlers
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright" },
        
        -- In 0.11, we pass the setup logic directly into the 'handlers' table
        handlers = {
          -- The default handler (replaces the old setup_handlers loop)
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,

          -- Specific override for Lua
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },
}
