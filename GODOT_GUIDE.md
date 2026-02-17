# Minivide: Godot Development Suite

This document tracks the specialized features added to Minivide to turn it into a full-featured Godot 4.x IDE.

## 🛠 The Godot "Power-up" (Refined Modular Setup)

We have chosen a **modular, high-performance architecture** over all-in-one plugins. This ensures maximum speed and compatibility with Neovim 0.11+.

### 1. Intelligence & Navigation (LSP)
- **Engine:** Built-in `vim.lsp` (Neovim 0.11+) + `nvim-lspconfig` templates.
- **Why this is better:** Communicates directly with Godot's engine without plugin overhead. Optimized for `blink.cmp` for near-instant completions.
- **Key Feature:** Internal LSP formatting is disabled in favor of `conform.nvim` to prevent conflicts and race conditions.
- **Location:** `lua/minivide/plugins/lsp.lua`

### 2. Deep Structural Awareness (Treesitter)
- **Engine:** `nvim-treesitter`.
- **Supported Formats:** `.gd` (Script), `.tscn` (Scene), `.res` (Resource), and `.gdshader` (Shaders).
- **What it does:** Beyond just colors, it understands the code structure. This allows for faster navigation, better indentation, and smart folding.
- **Location:** `lua/minivide/plugins/treesitter.lua`

### 3. Professional Debugging (DAP)
- **Engine:** `nvim-dap` + `nvim-dap-ui`.
- **What it does:** Allows you to set breakpoints and inspect variables without leaving the editor. When a breakpoint is hit, a "Pro" UI layout opens automatically with scopes, stacks, and watches.
- **Location:** `lua/minivide/plugins/dap.lua`

### 4. Industry-Standard Formatting
- **Engine:** `conform.nvim` using `gdformat`.
- **Why this is better:** Runs asynchronously, so your UI never freezes when saving large scripts. Supports range formatting (format only what you select).
- **Location:** `lua/minivide/plugins/formatting.lua`

### 5. Project Workflow (Godot.nvim)
- **Engine:** `lommix/godot.nvim`.
- **What it does:** Connects Neovim to your running Godot instance. Used primarily for launching scenes (`<leader>gr`, `<leader>gc`). Internal LSP/DAP features are disabled to prevent conflicts.
- **Location:** `lua/minivide/plugins/godot.lua`

---

## 📜 Change Log

### v1.2: The "Pro" Upgrade
- **Inlay Hints:** Enabled visual parameter names and types (`method(param: value)`).
- **NC Bridge:** Switched to `nc` (Netcat) for a more stable LSP connection.
- **Auto-Pipe Server:** Neovim now automatically starts a pipe server (`/tmp/godothost`) when a Godot project is detected.
- **Enhanced Highlighting:** Added semantic maps for parameters, enums, and methods.

### v1.1: Modular Refinement
- **Semantic Tokens:** Enabled the "Intelligence" layer in Catppuccin.
- **Treesitter Fix:** Migrated to v1.0+ setup logic to prevent crashes.
- **LSP De-conflict:** Disabled internal LSP formatting in favor of `conform.nvim`.

---

## 🚀 Pro Workflow Features

### 1. Inlay Hints (Visual Context)
Your editor now shows **parameter names** inline. This makes complex engine methods much easier to read without checking the docs.

### 2. Bi-directional Communication
Minivide now starts a server at `/tmp/godothost`. 
- **Godot Setup:** Set `Exec Flags` in Godot to:
  `--server /tmp/godothost --remote-send "<C-\><C-N>:n {file}<CR>{line}G{col}|"`
- **Result:** Clicking a script in the Godot Editor instantly opens it in your current Neovim session.

### 3. Semantic Color Intelligence
Member variables (`Lavender`), parameters (`Maroon`), and enums (`Yellow`) now have distinct colors. This mirrors the high-context look of professional TypeScript/React environments.

---

## 🚀 How to use your new workflow

### Running your Game
Instead of Alt-Tabbing to Godot to hit "Play", use the `<leader>g` (Godot) menu:
- Press `<leader>gr` to run the **Main Scene**.
- Press `<leader>gc` to run the **Current Scene** you are editing.
- Press `<leader>gl` to re-run whatever you ran **Last**.

### Debugging
1. Set a breakpoint on a line with `<leader>db`.
2. Start the game with `<leader>dc`.
3. The Debug UI will pop open. Use `<leader>do` to step over lines or `<leader>di` to step into functions.
4. When finished, hit `<leader>dt` to kill the debug session and close the UI.

### Formatting
Simply save the file (`<leader>w`). The code will automatically snap into the correct format. If you want to trigger it manually, use `<leader>mp`.

---

## ⌨️ Cheat Sheet

### Godot Actions (`<leader>g`)
| Key | Action |
|-----|--------|
| `r` | Run Project |
| `c` | Run Current Scene |
| `l` | Run Last Scene |

### Debugging (`<leader>d`)
| Key | Action |
|-----|--------|
| `b` | Toggle Breakpoint |
| `c` | Continue / Start |
| `i` | Step Into |
| `o` | Step Over |
| `t` | Terminate Debugger |

### LSP & Navigation
| Key | Action |
|-----|--------|
| `gd` | Go to Definition |
| `gr` | Show References |
| `K`  | Documentation Hover |
| `<leader>rn` | Rename Symbol |
| `<leader>ca` | Code Actions |

### General Minivide Keys
| Key | Action |
|-----|--------|
| `<leader>ff` | Find Files |
| `<leader>fg` | Live Grep (Search Text) |
| `<leader>w`  | Save File |
| `-`          | File Explorer (Oil) |
| `;;`         | Escape (Insert -> Normal) |
