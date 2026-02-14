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
        -- Configure the appearance of the floating window
        win_options = {
          winblend = 0,
        },
      })
    end,
  },
}
