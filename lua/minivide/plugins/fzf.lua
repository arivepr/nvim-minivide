return {
  {
    "ibhagwan/fzf-lua",
    -- Optional: depend on nvim-web-devicons for better visuals
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Initial setup for the base plugin
      require("fzf-lua").setup({
          -- We can leave this mostly empty because we'll drive 
          -- the logic from your fzf_custom.lua module
      })
    end,
  },
}
