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

return {}
