return {
  {
    "shaunsingh/seoul256.nvim",
    priority = 1000,
    config = function()
      -- Seoul256 configuration
      vim.g.seoul256_italic_comments = true
      vim.g.seoul256_italic_keywords = true
      vim.g.seoul256_contrast = true
      vim.g.seoul256_borders = true
      vim.g.seoul256_cursorline = true

      vim.cmd.colorscheme("seoul256")

      -- Darken the default background (plugin hardcodes #4c4c4c)
      local dark_bg = "#2e2e2e"
      vim.api.nvim_set_hl(0, "Normal", { bg = dark_bg })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = dark_bg })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = dark_bg })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = dark_bg })

      -- Seoul256 palette for custom highlights
      local c = {
        yellow = "#c3a769",
        paleblue = "#c78a69",
        pink = "#d0a39f",
        blue = "#93b2b2",
        fg = "#dfe0e0",
        orange = "#67a9aa",
        accent = "#ce8f6b",
        purple = "#c66d86",
        line_numbers = "#8a896a",
        ds_teal = "#5f9ea0",
      }

      local hl = vim.api.nvim_set_hl

      -- GDScript Structural Highlighting
      hl(0, "@type.gdscript", { fg = c.yellow })
      hl(0, "@variable.member.gdscript", { fg = c.paleblue })
      hl(0, "@variable.parameter.gdscript", { fg = c.pink })
      hl(0, "@function.method.gdscript", { fg = c.blue })
      hl(0, "@function.call.gdscript", { fg = c.ds_teal })
      hl(0, "@property.gdscript", { fg = c.paleblue })
      hl(0, "@variable.gdscript", { fg = c.fg })
      hl(0, "@constant.gdscript", { fg = c.orange })
      hl(0, "@annotation.gdscript", { fg = c.accent })

      -- Treesitter fallbacks
      hl(0, "@identifier.gdscript", { fg = c.fg })
      hl(0, "@attribute.gdscript", { fg = c.blue })
      hl(0, "@constructor.gdscript", { fg = c.yellow })
      hl(0, "@type.identifier.gdscript", { fg = c.yellow })

      -- Engine Specifics
      hl(0, "@punctuation.special.gdscript", { fg = c.orange })
      hl(0, "@keyword.onready.gdscript", { fg = c.accent, italic = true })
      hl(0, "@keyword.export.gdscript", { fg = c.accent, italic = true })
      hl(0, "@keyword.signal.gdscript", { fg = c.purple, bold = true })
      hl(0, "@variable.signal.gdscript", { fg = c.purple })

      -- Semantic Token Mapping
      hl(0, "@lsp.type.class.gdscript", { fg = c.yellow, bold = true })
      hl(0, "@lsp.type.property.gdscript", { fg = c.paleblue })
      hl(0, "@lsp.type.parameter.gdscript", { fg = c.pink })
      hl(0, "@lsp.type.method.gdscript", { fg = c.blue })
      hl(0, "@lsp.type.enum.gdscript", { fg = c.yellow })
      hl(0, "@lsp.type.enumMember.gdscript", { fg = c.ds_teal })
      hl(0, "@lsp.typemod.variable.readonly.gdscript", { fg = c.orange })

      -- Mini Starter: neutralize prefix coloring, let cursorline do the work
      hl(0, "MiniStarterItemPrefix", { link = "MiniStarterItem" })
      hl(0, "MiniStarterCurrent", { fg = c.orange, bold = true })

      -- Inlay Hints
      hl(0, "LspInlayHint", { fg = c.line_numbers, bg = "NONE", italic = true })
    end,
  },
}
