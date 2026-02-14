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

      -- Create an autocmd that runs when an LSP attaches to a buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }

          -- LSP Keybindings
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "Show references" })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover documentation" })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename symbol" })
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code actions" })
        end,
      })

      -- 2. Setup Mason-LSPConfig with the 0.11-style handlers
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright" },
        
        -- In 0.11, we pass the setup logic directly into the 'handlers' table
        handlers = {
          -- The default handler (replaces the old setup_handlers loop)
          function(server_name)
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            require("lspconfig")[server_name].setup({ capabilities = capabilities })
          end,

          -- Specific override for Lua
          ["lua_ls"] = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            require("lspconfig").lua_ls.setup({
              capabilities = capabilities,
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
