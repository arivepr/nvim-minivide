return {
  {
    'saghen/blink.cmp',
    -- Optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = 'v0.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to vscode
      -- 'super-tab' for mappings similar to lua-autocomplete
      keymap = { preset = 'default' },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your colorscheme doesn't support blink.cmp yet
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to match your font
        nerd_font_variant = 'normal'
      },

      -- Default list of enabled providers
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- Experimental signature help support
      signature = { enabled = true }
    },
    opts_extend = { "sources.default" }
  },
}
