return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
    opts = {
      ensure_installed = { 
        "lua", 
        "vim", 
        "vimdoc", 
        "gdscript", 
        "python" 
      },
      highlight = { 
        enable = true,
      },
      indent = { 
        enable = true 
      },
    },
  },
}
