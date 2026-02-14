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
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Explorer (Oil)" })

-- Fuzzy Finder (FZF-Lua)
-- We wrap these in functions so they only load fzf_custom when actually called
vim.keymap.set("n", "<leader>ff", function() require("minivide.settings.fzf_custom").project_files() end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", function() require("minivide.settings.fzf_custom").live_grep() end, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>", { desc = "Help Tags" })
