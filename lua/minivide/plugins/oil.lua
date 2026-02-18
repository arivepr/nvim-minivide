return {
  {
    "stevearc/oil.nvim",
    dependencies = {{ "nvim-mini/mini.icons" }},
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        columns = {
          "icon",
        },
        -- Deleted files will go to the trash instead of being permanently deleted
        delete_to_trash = true,
        -- Skip the confirmation popup for simple operations
        skip_confirm_for_simple_edits = true,
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = true,
        },
        float = {
          padding = 2,
          max_width = math.floor(vim.o.columns * 0.80),
          max_height = math.floor(vim.o.lines * 0.85),
          border = "single",
          win_options = {
            winblend = 0,
          },
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "oil",
        callback = function(args)
          local opts = { buffer = args.buf }
          local actions = require("oil.actions")

          -- Register the group buffer-locally so which-key only shows it in oil
          require("which-key").add({
            { "<leader>o", group = "oil", icon = "🛢", buffer = args.buf },
          })

          vim.keymap.set("n", "<leader>on", "o<Esc>", vim.tbl_extend("force", opts, { desc = "new file" }))
          vim.keymap.set("n", "<leader>od", function()
            -- Open a new line and append / so oil treats it as a directory
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("o<Esc>A/<Esc>0w", true, false, true), "n", false)
          end, vim.tbl_extend("force", opts, { desc = "new directory" }))
          vim.keymap.set("n", "<leader>or", "cW", vim.tbl_extend("force", opts, { desc = "rename" }))
          vim.keymap.set("n", "<leader>oR", actions.refresh.callback, vim.tbl_extend("force", opts, { desc = "refresh" }))
          vim.keymap.set("n", "<leader>os", require("oil").save, vim.tbl_extend("force", opts, { desc = "apply changes" }))
          vim.keymap.set("n", "<leader>oi", actions.preview.callback, vim.tbl_extend("force", opts, { desc = "preview" }))
          vim.keymap.set("n", "<leader>ot", actions.toggle_hidden.callback, vim.tbl_extend("force", opts, { desc = "toggle hidden" }))
        end,
      })
    end,
  },
}
