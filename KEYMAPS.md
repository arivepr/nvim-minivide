# Minivide Keymap Cheat Sheet

Leader key: `Space`

## General

| Key | Mode | Action |
|-----|------|--------|
| `;;` | Insert | Escape to Normal mode |
| `<leader>w` | Normal | Save file |
| `<leader>q` | Normal | Quit |

## File Explorer (Oil)

| Key | Mode | Action |
|-----|------|--------|
| `-` | Normal | Open parent directory |
| `<leader>e` | Normal | Toggle Oil file explorer |

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

## LSP (active when a language server attaches)

| Key | Mode | Action |
|-----|------|--------|
| `gd` | Normal | Go to definition |
| `gr` | Normal | Show references |
| `K` | Normal | Hover documentation |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>ca` | Normal, Visual | Code actions |

## Formatting

| Key | Mode | Action |
|-----|------|--------|
| `<leader>mp` | Normal, Visual | Format file or selection |

Format on save is also enabled automatically for: gdscript (`gdformat`), lua (`stylua`), python (`isort` + `black`).

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

## Godot (`<leader>g`)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gr` | Normal | Run project |
| `<leader>gc` | Normal | Run current scene (.tscn) |
| `<leader>gl` | Normal | Run last scene |
| `<leader>gh` | Normal | Search Godot documentation |

## DAP-UI Layout Reference

When a debug session starts, two panels auto-open:

**Right sidebar (40 cols)**
- Scopes (40%) — local/global variables with live values
- Watches (20%) — user-defined watch expressions
- Stacks (25%) — call stack, click a frame to jump
- Breakpoints (15%) — all breakpoints across the project

**Bottom tray (15 lines)**
- Console (60%) — Godot stdout/stderr output stream
- REPL (40%) — evaluate expressions against the current frame
