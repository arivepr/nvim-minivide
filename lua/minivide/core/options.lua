local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.ignorecase = true


opt.shiftwidth = 4
opt.tabstop = 4
opt.scrolloff = 8

opt.termguicolors = true
opt.cursorline = true
opt.smartindent = true
opt.smarttab = true
opt.smartcase = true

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.swapfile = false
opt.backup = false
opt.clipboard = "unnamedplus"

-- Godot Auto-Server Support
-- This starts a pipe server so Godot's "External Editor" feature works flawlessly.
local function start_godot_server()
  local project_file = vim.fs.find("project.godot", { upward = true })[1]
  if project_file then
    -- Use a consistent pipe name for this project
    -- This matches the flag: --server /tmp/godothost
    local addr = "/tmp/godothost"
    if not vim.tbl_contains(vim.fn.serverlist(), addr) then
      pcall(vim.fn.serverstart, addr)
    end
  end
end

-- Run the check whenever we open a file
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  callback = start_godot_server,
})
