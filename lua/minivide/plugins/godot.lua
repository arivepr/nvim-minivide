-- Godot run commands (no plugin needed - we handle LSP in lsp.lua, DAP in dap.lua)

local function godot_project_root()
  local found = vim.fs.find("project.godot", { upward = true })
  return found[1] and vim.fn.fnamemodify(found[1], ":h") or nil
end

local last_scene = nil

vim.api.nvim_create_user_command("GodotRun", function()
  local root = godot_project_root()
  if not root then
    vim.notify("No project.godot found", vim.log.levels.ERROR)
    return
  end
  vim.fn.jobstart({ "godot", "--path", root }, { detach = true })
end, { desc = "Godot: Run project" })

vim.api.nvim_create_user_command("GodotRunCurrent", function()
  local root = godot_project_root()
  if not root then
    vim.notify("No project.godot found", vim.log.levels.ERROR)
    return
  end
  local file = vim.fn.expand("%:p")
  if not file:match("%.tscn$") then
    vim.notify("Current file is not a .tscn scene", vim.log.levels.WARN)
    return
  end
  local rel = file:sub(#root + 2) -- strip root + separator
  last_scene = "res://" .. rel
  vim.fn.jobstart({ "godot", "--path", root, last_scene }, { detach = true })
end, { desc = "Godot: Run current scene" })

vim.api.nvim_create_user_command("GodotRunLast", function()
  local root = godot_project_root()
  if not root then
    vim.notify("No project.godot found", vim.log.levels.ERROR)
    return
  end
  if not last_scene then
    vim.notify("No previous scene to run", vim.log.levels.WARN)
    return
  end
  vim.fn.jobstart({ "godot", "--path", root, last_scene }, { detach = true })
end, { desc = "Godot: Run last scene" })

-- Keymaps
vim.keymap.set("n", "<leader>gr", "<cmd>GodotRun<cr>", { desc = "Godot: Run project" })
vim.keymap.set("n", "<leader>gc", "<cmd>GodotRunCurrent<cr>", { desc = "Godot: Run current scene" })
vim.keymap.set("n", "<leader>gl", "<cmd>GodotRunLast<cr>", { desc = "Godot: Run last scene" })

-- F-key bindings only in Godot filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gdscript", "gdshader", "godot_resource" },
  callback = function(args)
    local opts = { buffer = args.buf }
    -- Scene running
    vim.keymap.set("n", "<F5>", "<cmd>GodotRun<cr>", vim.tbl_extend("force", opts, { desc = "Godot: Run project" }))
    vim.keymap.set("n", "<F6>", "<cmd>GodotRunCurrent<cr>", vim.tbl_extend("force", opts, { desc = "Godot: Run current scene" }))
    vim.keymap.set("n", "<F4>", "<cmd>GodotRunLast<cr>", vim.tbl_extend("force", opts, { desc = "Godot: Run last scene" }))

    -- Debugging (matches Godot editor F-keys)
    local dap = require("dap")
    vim.keymap.set("n", "<F7>", dap.continue, vim.tbl_extend("force", opts, { desc = "Godot: Continue/Pause" }))
    vim.keymap.set("n", "<F8>", dap.terminate, vim.tbl_extend("force", opts, { desc = "Godot: Stop debugging" }))
    vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, vim.tbl_extend("force", opts, { desc = "Godot: Toggle breakpoint" }))
    vim.keymap.set("n", "<F10>", dap.step_over, vim.tbl_extend("force", opts, { desc = "Godot: Step over" }))
    vim.keymap.set("n", "<F11>", dap.step_into, vim.tbl_extend("force", opts, { desc = "Godot: Step into" }))
  end,
})

return {}
