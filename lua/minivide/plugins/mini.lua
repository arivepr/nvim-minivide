return {
  -- Autopairs: auto-close brackets, quotes, etc.
  {
    "nvim-mini/mini.pairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Comment toggling: gcc for line, gc + motion for block
  {
    "nvim-mini/mini.comment",
    event = "VeryLazy",
    opts = {},
  },

  -- Surround: sa (add), sd (delete), sr (replace)
  {
    "nvim-mini/mini.surround",
    event = "VeryLazy",
    opts = {},
  },

  -- Starter: dashboard when opening nvim with no arguments
  {
    "nvim-mini/mini.starter",
    lazy = false,
    config = function()
      local starter = require("mini.starter")
      starter.setup({
        items = {
          starter.sections.sessions(5, true),
          starter.sections.recent_files(5, false),
          {
            { name = "Find files", action = "lua require('minivide.settings.fzf_custom').project_files()", section = "Quick actions" },
            { name = "Live grep", action = "lua require('minivide.settings.fzf_custom').live_grep()", section = "Quick actions" },
            { name = "File explorer", action = "lua require('oil').open_float()", section = "Quick actions" },
            { name = "Git status", action = "FzfLua git_status", section = "Quick actions" },
          },
        },
        header = "Minivide",
        footer = "",
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniStarterOpened",
        callback = function(args)
          local buf = args.buf
          vim.keymap.set("n", "j", function()
            MiniStarter.update_current_item("next")
          end, { buffer = buf, silent = true })
          vim.keymap.set("n", "k", function()
            MiniStarter.update_current_item("prev")
          end, { buffer = buf, silent = true })
        end,
      })
    end,
  },

  -- Sessions: simple session management
  {
    "nvim-mini/mini.sessions",
    lazy = false,
    config = function()
      require("mini.sessions").setup({
        autoread = false,
        autowrite = true,
        directory = vim.fn.stdpath("data") .. "/sessions",
      })

      vim.keymap.set("n", "<leader>Ss", function()
        vim.ui.input({ prompt = "Session name: " }, function(name)
          if name and name ~= "" then
            MiniSessions.write(name)
          end
        end)
      end, { desc = "save session" })

      vim.keymap.set("n", "<leader>Sl", function()
        MiniSessions.select("read")
      end, { desc = "load session" })

      vim.keymap.set("n", "<leader>Sd", function()
        MiniSessions.select("delete")
      end, { desc = "delete session" })

      vim.keymap.set("n", "<leader>Sw", function()
        local name = vim.v.this_session
        if name and name ~= "" then
          MiniSessions.write(nil)
          vim.notify("Session updated", vim.log.levels.INFO)
        else
          vim.notify("No active session", vim.log.levels.WARN)
        end
      end, { desc = "write current session" })
    end,
  },

  -- Indentscope: animated vertical line for current scope
  {
    "nvim-mini/mini.indentscope",
    event = "VeryLazy",
    opts = {
      symbol = "│",
      options = {
        try_as_border = true,
      },
      draw = {
        delay = 25,
        animation = function(s, n) return 10 end,
      },
    },
    init = function()
      -- Disable for filetypes where it doesn't make sense
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "lazy", "mason", "oil", "toggleterm" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
