return {
  {
    "lewis6742/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 300,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Hunk navigation
        map("n", "]c", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, "Next hunk")

        map("n", "[c", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, "Previous hunk")

        -- Actions under <leader>G
        map("n", "<leader>Gp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>Gs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>Gr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>Gu", gs.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>Gb", gs.toggle_current_line_blame, "Toggle line blame")
        map("n", "<leader>Gd", gs.diffthis, "Diff against index")
        map("n", "<leader>GD", function() gs.diffthis("~") end, "Diff against last commit")

        -- Visual mode stage/reset
        map("v", "<leader>Gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage selection")
        map("v", "<leader>Gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset selection")
      end,
    },
  },
}
