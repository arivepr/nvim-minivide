-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set a short timeout (in milliseconds) so the double-tap feels snappy
vim.opt.timeoutlen = 300 

-- Map ;; to Escape in Insert Mode
vim.keymap.set('i', ';;', '<Esc>', { noremap = true, silent = true })

-- File Management
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "-", function() require("oil").open_float() end, { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>e", function()
  if vim.bo.filetype == "oil" then
    require("oil").close()
  else
    require("oil").open_float()
  end
end, { desc = "Toggle Oil" })

-- Move lines up/down
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Toggle comment
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment" })
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment" })

-- Buffer Manipulation
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>FzfLua buffers<cr>", { desc = "List buffers" })

-- Theme
vim.keymap.set("n", "<leader>tl", function() require("minivide.core.palette").toggle() end, { desc = "Toggle light/dark" })

-- Fuzzy Finder (FZF-Lua)
-- We wrap these in functions so they only load fzf_custom when actually called
vim.keymap.set("n", "<leader>ff", function() require("minivide.settings.fzf_custom").project_files() end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", function() require("minivide.settings.fzf_custom").live_grep() end, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>", { desc = "Help Tags" })
