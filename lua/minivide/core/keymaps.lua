-- Set a short timeout (in milliseconds) so the double-tap feels snappy
vim.opt.timeoutlen = 300 

-- Map ;; to Escape in Insert Mode
vim.keymap.set('i', ';;', '<Esc>', { noremap = true, silent = true })
