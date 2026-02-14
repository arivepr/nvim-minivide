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
