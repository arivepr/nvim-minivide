return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- =======================================================================
      -- Breakpoint Signs — visual anchors in the sign column
      -- =======================================================================
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticOk", linehl = "DiffAdd", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticHint", linehl = "", numhl = "" })

      -- =======================================================================
      -- DAP-UI Layout — optimized for a right-column Neovim on ultrawide
      --
      -- Right sidebar (40 cols): scopes, watches, stacks, breakpoints
      --   -> The persistent "what am I looking at" context panel
      --
      -- Bottom tray (15 lines): console + repl
      --   -> Godot output stream + interactive evaluation
      -- =======================================================================
      dapui.setup({
        icons = { expanded = "", collapsed = "", current_frame = "" },
        controls = {
          enabled = true,
          element = "repl",
          icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "",
            terminate = "",
            disconnect = "",
          },
        },
        layouts = {
          -- Sidebar: the debug context panel
          {
            elements = {
              { id = "scopes", size = 0.40 },  -- locals, globals, upvalues
              { id = "watches", size = 0.20 },  -- user-defined watch expressions
              { id = "stacks", size = 0.25 },   -- call stack with frame navigation
              { id = "breakpoints", size = 0.15 }, -- all breakpoints at a glance
            },
            position = "right",
            size = 40,
          },
          -- Bottom tray: output and interaction
          {
            elements = {
              { id = "console", size = 0.60 },  -- Godot stdout/stderr stream
              { id = "repl", size = 0.40 },      -- evaluate expressions live
            },
            position = "bottom",
            size = 15,
          },
        },
        floating = {
          border = "single",
          mappings = { close = { "q", "<Esc>" } },
        },
        render = {
          indent = 1,
          max_value_lines = 100,
        },
      })

      -- =======================================================================
      -- Auto open/close UI on debug session lifecycle
      -- =======================================================================
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- =======================================================================
      -- Godot DAP Adapter
      -- =======================================================================
      dap.adapters.godot = {
        type = "server",
        host = "127.0.0.1",
        port = 6006,
      }

      dap.configurations.gdscript = {
        {
          type = "godot",
          request = "launch",
          name = "Launch scene",
          project = "${workspaceFolder}",
          launch_scene = true,
        },
      }

      -- =======================================================================
      -- Keymaps — full debugger control
      -- =======================================================================

      -- Session control
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue / Start" })
      vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
      vim.keymap.set("n", "<leader>dr", dap.run_last, { desc = "Re-run last session" })

      -- Stepping
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
      vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
      vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to cursor" })

      -- Breakpoints
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Condition: "))
      end, { desc = "Conditional breakpoint" })
      vim.keymap.set("n", "<leader>dl", function()
        dap.set_breakpoint(nil, nil, vim.fn.input("Log message: "))
      end, { desc = "Log point" })
      vim.keymap.set("n", "<leader>dx", dap.clear_breakpoints, { desc = "Clear all breakpoints" })

      -- Inspection
      vim.keymap.set("n", "<leader>dk", function()
        dapui.eval(nil, { enter = true })
      end, { desc = "Eval under cursor" })
      vim.keymap.set("v", "<leader>dk", function()
        dapui.eval(nil, { enter = true })
      end, { desc = "Eval selection" })
      vim.keymap.set("n", "<leader>dw", function()
        dapui.elements.watches.add(vim.fn.expand("<cword>"))
      end, { desc = "Watch word under cursor" })

      -- UI toggles
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle UI" })
      vim.keymap.set("n", "<leader>df", function()
        dapui.float_element("console", { enter = true })
      end, { desc = "Float console" })
    end,
  },
}
