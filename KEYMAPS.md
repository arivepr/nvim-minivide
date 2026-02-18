# Minivide Keymap Cheat Sheet

Leader key: `Space`

## General

| Key | Mode | Action |
|-----|------|--------|
| `;;` | Insert | Escape to Normal mode |
| `<leader>w` | Normal | Save file |
| `<leader>q` | Normal | Quit |
| `<leader>/` | Normal | Toggle comment |
| `<leader>/` | Visual | Toggle comment |
| `<leader>G` | Normal | Open Lazygit |

## File Explorer (Oil)

| Key | Mode | Action |
|-----|------|--------|
| `-` | Normal | Open parent directory (floating) |
| `<leader>e` | Normal | Toggle Oil file explorer (floating) |

### Oil Buffer Actions (`<leader>o` — only visible inside Oil)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>on` | Normal | New file |
| `<leader>od` | Normal | New directory |
| `<leader>or` | Normal | Rename |
| `<leader>oR` | Normal | Refresh |
| `<leader>os` | Normal | Apply changes (save) |
| `<leader>oi` | Normal | Preview |
| `<leader>ot` | Normal | Toggle hidden files |

Hidden files: `.godot/`, `*.uid`, `*.import`, `server.pipe`, dotfiles.

## Buffers (`<leader>b`)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>bn` | Normal | Next buffer |
| `<leader>bp` | Normal | Previous buffer |
| `<leader>bd` | Normal | Delete buffer |
| `<leader>bb` | Normal | List buffers (fzf) |

## Find (`<leader>f`)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ff` | Normal | Find files in project |
| `<leader>fg` | Normal | Live grep in project |
| `<leader>fb` | Normal | Find buffers |
| `<leader>fh` | Normal | Search help tags |

## Harpoon (`<leader>h`)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ha` | Normal | Add file to harpoon list |
| `<leader>hh` | Normal | Toggle quick menu |
| `<leader>h1` | Normal | Jump to file 1 |
| `<leader>h2` | Normal | Jump to file 2 |
| `<leader>h3` | Normal | Jump to file 3 |
| `<leader>h4` | Normal | Jump to file 4 |
| `<leader>hn` | Normal | Next mark |
| `<leader>hb` | Normal | Previous mark |

Harpooned files appear in the tabline at the top of the screen.

## LSP (`<leader>l` — active when a language server attaches)

### Navigation

| Key | Mode | Action |
|-----|------|--------|
| `gd` | Normal | Go to definition |
| `gr` | Normal | Show references |
| `K` | Normal | Hover documentation |
| `<leader>li` | Normal | Go to implementation |
| `<leader>ls` | Normal | Document symbols (current file) |
| `<leader>lw` | Normal | Workspace symbols (whole project) |

### Actions

| Key | Mode | Action |
|-----|------|--------|
| `<leader>la` | Normal, Visual | Code actions |
| `<leader>lr` | Normal | Rename symbol |
| `<C-k>` | Insert | Signature help (function args) |

### Diagnostics

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ld` | Normal | Show line diagnostic in float |
| `[d` | Normal | Jump to previous diagnostic |
| `]d` | Normal | Jump to next diagnostic |

### Linting

Linters run automatically and show diagnostics alongside LSP:
- **Python**: ruff (LSP) — code quality, unused imports, style
- **JS/TS/React**: eslint (LSP) — hooks rules, accessibility, auto-fixes on save
- **Go**: golangci-lint (nvim-lint) — runs on save

## Formatting

| Key | Mode | Action |
|-----|------|--------|
| `<leader>mp` | Normal, Visual | Format file or selection |

Format on save is enabled for: gdscript (`gdformat`), lua (`stylua`), python (`isort` + `black`), dart (`dart_format`), go (`goimports` + `gofumpt`), js/ts/tsx/jsx/html/css/json (`prettierd`).

## Debug (`<leader>d`)

### Session Control

| Key | Mode | Action |
|-----|------|--------|
| `<leader>dc` | Normal | Continue / Start debug session |
| `<leader>dt` | Normal | Terminate session |
| `<leader>dr` | Normal | Re-run last session |

### Stepping

| Key | Mode | Action |
|-----|------|--------|
| `<leader>di` | Normal | Step into |
| `<leader>do` | Normal | Step over |
| `<leader>dO` | Normal | Step out of current function |
| `<leader>dC` | Normal | Run to cursor position |

### Breakpoints

| Key | Mode | Action |
|-----|------|--------|
| `<leader>db` | Normal | Toggle breakpoint |
| `<leader>dB` | Normal | Conditional breakpoint (prompts for expression) |
| `<leader>dl` | Normal | Log point (prints message without stopping) |
| `<leader>dx` | Normal | Clear all breakpoints |

### Inspection

| Key | Mode | Action |
|-----|------|--------|
| `<leader>dk` | Normal | Eval word under cursor (floating window) |
| `<leader>dk` | Visual | Eval selection (floating window) |
| `<leader>dw` | Normal | Add word under cursor to watches |

### UI

| Key | Mode | Action |
|-----|------|--------|
| `<leader>du` | Normal | Toggle debug UI on/off |
| `<leader>df` | Normal | Pop console as floating window |

### Breakpoint Signs

| Sign | Meaning |
|------|---------|
| `` | Breakpoint |
| `` | Conditional breakpoint |
| `` | Log point |
| `` | Stopped (current line) |
| `` | Rejected breakpoint |

### DAP-UI Layout Reference

When a debug session starts, two panels auto-open:

**Right sidebar (40 cols)**
- Scopes (40%) — local/global variables with live values
- Watches (20%) — user-defined watch expressions
- Stacks (25%) — call stack, click a frame to jump
- Breakpoints (15%) — all breakpoints across the project

**Bottom tray (15 lines)**
- Console (60%) — stdout/stderr output stream
- REPL (40%) — evaluate expressions against the current frame

## Godot (`<leader>g`)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gr` | Normal | Run project |
| `<leader>gc` | Normal | Run current scene (.tscn) |
| `<leader>gl` | Normal | Run last scene |
| `<leader>gh` | Normal | Search Godot documentation |

### Godot F-Keys (only in gdscript, gdshader, godot_resource files)

| Key | Action |
|-----|--------|
| `F4` | Run last scene |
| `F5` | Run project |
| `F6` | Run current scene |
| `F7` | Continue / Pause debugging |
| `F8` | Stop debugging |
| `F9` | Toggle breakpoint |
| `F10` | Step over |
| `F11` | Step into |

## Flutter (`<leader>F`)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>Fr` | Normal | Run |
| `<leader>Fq` | Normal | Quit |
| `<leader>Fl` | Normal | Hot reload |
| `<leader>FR` | Normal | Hot restart |
| `<leader>Fd` | Normal | Devices |
| `<leader>Fe` | Normal | Emulators |
| `<leader>Fo` | Normal | Widget outline |
| `<leader>Ft` | Normal | Dev tools |
| `<leader>Fs` | Normal | Restart LSP |

## Terminal (`<leader>T`)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>Tr` | Normal | Open terminal in right split (25% width) |
| `<leader>Tb` | Normal | Open terminal in bottom split (25% height) |
| `<leader>Tf` | Normal | Open floating terminal |
| `<leader>Tq` | Normal | Close terminal |

Exit terminal mode back to normal mode with `<C-\><C-n>`.

## Sessions (`<leader>S`)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>Ss` | Normal | Save session (prompts for name) |
| `<leader>Sl` | Normal | Load session |
| `<leader>Sd` | Normal | Delete session |
| `<leader>Sw` | Normal | Write/update current session |

Sessions auto-save on quit and persist across reboots at `~/.local/share/nvim/sessions/`.

## Mini Starter (Dashboard)

| Key | Mode | Action |
|-----|------|--------|
| `j` | Normal | Next item |
| `k` | Normal | Previous item |
| `<CR>` | Normal | Select item |
| `<Esc>` | Normal | Clear search query |

## Which-Key Groups

Pressing `<leader>` shows all available groups. Inside an Oil buffer, only Oil-relevant groups are shown.

| Prefix | Group |
|--------|-------|
| `<leader>b` | buffer |
| `<leader>f` | find |
| `<leader>l` | lsp |
| `<leader>d` | debug |
| `<leader>h` | harpoon |
| `<leader>F` | flutter |
| `<leader>g` | godot |
| `<leader>T` | terminal |
| `<leader>S` | session |
| `<leader>o` | oil (only in Oil buffers) |
