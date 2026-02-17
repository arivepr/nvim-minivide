return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Load this first
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = false,
        term_colors = true,
        integrations = {
          cmp = true,
          fzf = true,
          gitsigns = true,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
            semantic_tokens = true, -- <--- Added this
          },
          telescope = {
            enabled = true,
          },
          treesitter = true,
          which_key = true,
        },
        custom_highlights = function(colors)
          return {
            -- GDScript Structural Highlighting (React/TS Semantic Mapping)
            ["@type.gdscript"] = { fg = colors.yellow },               -- Classes (PhysicsRayQueryParameters2D)
            ["@variable.member.gdscript"] = { fg = colors.lavender },  -- Class members (player)
            ["@variable.parameter.gdscript"] = { fg = colors.maroon }, -- Function parameters (spawn_position)
            ["@function.method.gdscript"] = { fg = colors.blue },      -- Methods (.create, .global_position)
            ["@function.call.gdscript"] = { fg = colors.blue },        -- Call expressions
            ["@property.gdscript"] = { fg = colors.lavender },         -- Properties
            ["@variable.gdscript"] = { fg = colors.text },             -- Local variables
            ["@constant.gdscript"] = { fg = colors.peach },            -- Constants (TERRAIN_LAYER_ID)
            ["@annotation.gdscript"] = { fg = colors.flamingo },       -- @onready, @export
            
            -- Treesitter fallbacks to catch what generic @variable might miss
            ["@identifier.gdscript"] = { fg = colors.text },           
            ["@attribute.gdscript"] = { fg = colors.blue },            -- .global_position, .create
            ["@constructor.gdscript"] = { fg = colors.yellow },        -- Class constructors/names
            ["@type.identifier.gdscript"] = { fg = colors.yellow },
            
            -- Engine Specifics
            ["@punctuation.special.gdscript"] = { fg = colors.peach }, -- $Node and %UniqueNode
            ["@keyword.onready.gdscript"] = { fg = colors.flamingo, style = { "italic" } },
            ["@keyword.export.gdscript"] = { fg = colors.flamingo, style = { "italic" } },
            ["@keyword.signal.gdscript"] = { fg = colors.rosewater, style = { "bold" } }, 
            ["@variable.signal.gdscript"] = { fg = colors.rosewater },

            -- Semantic Token Mapping (The "Intelligence" layer)
            ["@lsp.type.class.gdscript"] = { fg = colors.yellow, style = { "bold" } },
            ["@lsp.type.property.gdscript"] = { fg = colors.lavender },
            ["@lsp.type.parameter.gdscript"] = { fg = colors.maroon },
            ["@lsp.type.method.gdscript"] = { fg = colors.blue },
            ["@lsp.type.enum.gdscript"] = { fg = colors.yellow },
            ["@lsp.type.enumMember.gdscript"] = { fg = colors.teal },
            ["@lsp.typemod.variable.readonly.gdscript"] = { fg = colors.peach },
            
            -- Inlay Hints
            ["LspInlayHint"] = { fg = colors.overlay0, bg = "NONE", style = { "italic" } },
          }
        end,
      })

      -- setup must be called before loading
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
