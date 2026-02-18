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

      -- Unified borders for all LSP floating windows
      vim.diagnostic.config({
        float = { border = "single" },
      })
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

      -- Create an autocmd that runs when an LSP attaches to a buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }

          -- LSP Keybindings
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "Show references" })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover documentation" })
          -- LSP group keybindings
          vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "code actions" })
          vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "rename symbol" })
          vim.keymap.set("n", "<leader>ls", vim.lsp.buf.document_symbol, { buffer = ev.buf, desc = "document symbols" })
          vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "implementation" })
          vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { buffer = ev.buf, desc = "line diagnostic" })
          vim.keymap.set("n", "<leader>lw", vim.lsp.buf.workspace_symbol, { buffer = ev.buf, desc = "workspace symbols" })

          -- Diagnostic navigation
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = ev.buf, desc = "Prev diagnostic" })
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = ev.buf, desc = "Next diagnostic" })

          -- Signature help in insert mode
          vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature help" })
        end,
      })

      -- 2. Setup Mason-LSPConfig with the 0.11-style handlers
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright" },

        -- In 0.11, we use the new vim.lsp.config and vim.lsp.enable APIs
        handlers = {
          -- The default handler
          function(server_name)
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            vim.lsp.config(server_name, { capabilities = capabilities })
            vim.lsp.enable(server_name)
          end,

          -- Specific override for Lua
          ["lua_ls"] = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            vim.lsp.config("lua_ls", {
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                },
              },
            })
            vim.lsp.enable("lua_ls")
          end,
        },
      })

      -- 3. Setup Godot LSP (Pro-level setup)
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      -- Enable semantic tokens and inlay hints for high-context coding
      capabilities.textDocument = capabilities.textDocument or {}
      capabilities.textDocument.semanticTokens = { dynamicRegistration = true }

      vim.lsp.config("gdscript", {
        capabilities = capabilities,
        filetypes = { "gdscript" },
        -- Use nc to bridge the connection (more stable for context-rich projects)
        cmd = { "nc", "127.0.0.1", "6005" },
        -- Integrate extended LSP handlers for documentation and signals
        handlers = require("gdscript-extended-lsp").handlers,
        -- Root dir detection ensures cross-file signals and node paths work
        root_dir = function(fname)
          return vim.fs.root(fname, { "project.godot", ".git" })
        end,
        on_attach = function(client, bufnr)
          -- Disable LSP formatting to let conform.nvim handle it
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false

          -- Enable Inlay Hints (Visual context for parameters/types)
          if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
        end,
      })
      vim.lsp.enable("gdscript")
    end,
  },
}
