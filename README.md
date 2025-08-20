# ⚡ Neovim Config
My personal Neovim configuration using **Lua** and [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

<br>

## 📂 Files
- `init.lua` → Entry point, loads keymaps, plugins, and autocmds
- `lazy.lua` → Bootstraps and configures lazy.nvim
- `plugins.lua` → Plugin list and setup
- `keymaps.lua` → Custom key mappings (editing, navigation, FZF, tree, etc.)
- `autocmds.lua` → Auto commands (e.g. trim trailing whitespace, line numbers)
<br>

## ✨ Features
- **Plugin manager**: lazy.nvim  
- **UI**: Catppuccin colorscheme, lualine statusline  
- **File navigation**: nvim-tree, fzf-lua  
- **Editing helpers**: mini.nvim (pairs, comment, align, ai), nvim-surround, nvim-spider  
- **LSP**: mason.nvim + mason-lspconfig for Python (pyright) and Lua (lua_ls)  
- **Treesitter** for syntax highlighting and text objects  
- **Dashboard**: alpha-nvim + persistence for sessions  

<br>

## 🚀 Setup
1. Install [Neovim](https://neovim.io/) (≥ 0.9 recommended).  
2. Clone this repo into your Neovim config folder:  
   ```sh
   git clone https://github.com/Asim2/nvim_config.git ~/.config/nvim
   ```
    (On Windows: $env:LOCALAPPDATA\nvim)
    
3. Start Neovim – plugins will auto-install on first launch.

<br>

## 📦 Requirements

To get the most out of this config, make sure the following are installed and available in your `PATH`:

- [Neovim](https://neovim.io/) (v0.9 or newer recommended)
- [Git](https://git-scm.com/) (needed to fetch plugins with lazy.nvim)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (for live grep)
- [fzf](https://github.com/junegunn/fzf) (for fuzzy finding)

<br>

## ⌨️ Custom Keybindings

**Leader key:** `,`

#### General / Editing
- `<CR>` → clear search highlight (`:nohlsearch`)
- `<leader>o` → insert blank line **below** (stay in normal mode)
- `<leader>O` → insert blank line **above** (stay in normal mode)
- `<leader><Tab>` → toggle **relative line numbers**

#### File Paths → Clipboard
- `<F4>` → yank **directory** of current file to clipboard
- `<F5>` → yank **full path** of current file to clipboard

#### Diagnostics
- `<leader>l` → toggle diagnostics (signs/underline; inline text stays off)

#### Terminal
- In terminal mode: `<Esc>` → exit to normal mode

#### Nvim-tree (global)
- `<C-t>` → toggle file tree
- `<leader>t` → reveal **current file** in tree

#### Nvim-tree (inside tree window)
- `o` → open file
- `i` → open in **horizontal** split
- `s` → open in **vertical** split
- `C` → change root to node
- `u` → change root to parent
- `p` → jump to parent directory
- `?` → toggle help
- `<C-t>` → close tree and return focus to previous window

#### FZF-Lua
- `<leader>ff` → find files
- `<leader>fr` → recent files
- `<leader>fb` → buffers
- `<leader>fg` → live grep
- `<leader>fc` → find files in **config** (`~/.config/nvim`)
- `<leader>p` → command palette

#### Splits / Windows / Tabs
- `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` → move focus left / down / up / right
- `<C-Left>` / `<C-Right>` → resize **width** −5 / +5
- `<C-Up>` / `<C-Down>` → resize **height** +2 / −2
- `<A-Left>` / `<A-Right>` → previous / next **tab**

#### “Workflowy-like” Line Moves & Indent
- **Move lines**
  - Normal: `<S-A-j>` / `<S-A-k>` → move line down / up
  - Insert: `<S-A-j>` / `<S-A-k>` → move line down / up (return to insert)
  - Visual: `<S-A-j>` / `<S-A-k>` → move selection down / up
- **Indent**
  - Normal: `<S-A-l>` → indent right
  - Normal: `<S-A-h>` → indent left
  - Visual: `<S-A-l>` / `<S-A-h>` → keep selection and indent
