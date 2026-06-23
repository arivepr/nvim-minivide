local M = {}

M.dark = {
  bg = "#2e2e2e",
  statusline_bg = "#2b2b2b",
  fg = "#dfe0e0",
  blue = "#93b2b2",
  green = "#678568",
  red = "#a07474",
  yellow = "#c3a769",
  purple = "#c66d86",
  orange = "#67a9aa",
  accent = "#ce8f6b",
  line_numbers = "#8a896a",
  ds_teal = "#5f9ea0",
  cmdline_fg = "#a07474",
  pink = "#d0a39f",
  paleblue = "#c78a69",
  disabled = "#414863",
}

M.light = {
  bg = "#c2beb5",
  statusline_bg = "#b8b4ab",
  fg = "#2e2e2e",
  blue = "#2e5f5f",
  green = "#2a4a2d",
  red = "#6e3535",
  yellow = "#6a5520",
  purple = "#7a3050",
  orange = "#2a5f5f",
  accent = "#7a4520",
  line_numbers = "#7a7a60",
  ds_teal = "#1a4040",
  cmdline_fg = "#5a3535",
  pink = "#6e4040",
  paleblue = "#6e4020",
  disabled = "#958d7a",
}

M.mode = "dark"

function M.get()
  return M[M.mode]
end

function M.apply_highlights(c)
  local hl = vim.api.nvim_set_hl

  -- Background overrides
  hl(0, "Normal", { bg = c.bg })
  hl(0, "NormalFloat", { bg = c.bg })
  hl(0, "SignColumn", { bg = c.bg })
  hl(0, "NormalNC", { bg = c.bg })

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

  -- Mini Starter
  hl(0, "MiniStarterItemPrefix", { link = "MiniStarterItem" })
  hl(0, "MiniStarterCurrent", { fg = c.orange, bold = true })

  -- Command line area
  hl(0, "MsgArea", { fg = c.cmdline_fg })

  -- Inlay Hints
  hl(0, "LspInlayHint", { fg = c.line_numbers, bg = "NONE", italic = true })
end

function M.apply_tabline(c)
  local hl = vim.api.nvim_set_hl
  hl(0, "MinivideTablActive", { fg = c.accent, bg = c.bg, bold = true })
  hl(0, "MinivideTablInactive", { fg = c.line_numbers, bg = c.bg })
  hl(0, "MinivideTablineBg", { fg = c.line_numbers, bg = c.bg })
end

function M.apply_lualine(c)
  local ok, lualine = pcall(require, "lualine")
  if not ok then return end

  local build = require("minivide.core.lualine_config")
  local config = build(c)
  lualine.setup(config)
end

function M.toggle()
  M.mode = M.mode == "dark" and "light" or "dark"
  local c = M.get()

  -- Reload colorscheme
  if M.mode == "dark" then
    vim.o.background = "dark"
    vim.cmd.colorscheme("seoul256")
  else
    vim.cmd.colorscheme("seoul256")
    vim.o.background = "light"
  end

  M.apply_highlights(c)
  M.apply_tabline(c)
  M.apply_lualine(c)
end

return M
