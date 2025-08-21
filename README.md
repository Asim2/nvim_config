# Neovinimal
A minimal Neovim config with **Lua** and [lazy.nvim](https://github.com/folke/lazy.nvim).

<br>

## 📂 Files
- `init.lua` → Entry point, loads keymaps, plugins, and autocmds
- `lazy.lua` → Bootstraps and configures lazy.nvim
- `plugins.lua` → Plugin list and setup
- `keymaps.lua` → Custom key mappings (editing, navigation, FZF, tree, etc.)
- `autocmds.lua` → Auto commands (e.g. trim trailing whitespace, line numbers)
<br>

## ✨ Plugins
- **Plugin manager**: lazy.nvim  
- **UI**: Catppuccin colorscheme, lualine statusline  
- **File explorer**: nvim-tree, fzf-lua  
- **Editing helpers**: mini.nvim (pairs, comment, align etc), nvim-surround, nvim-spider (smarter word motions)  
- **LSP**: mason.nvim + mason-lspconfig for installing and managing LSPs, linters, formatters
- **Treesitter** for syntax highlighting and text objects  
- **Neomux** to emulate Tmux style tab and window splitting within a single Neovim session 
- **Dashboard**: alpha-nvim + persistence for sessions


<br>

## 📦 Requirements

Have these on your `PATH`:

- [Neovim](https://neovim.io/) (v0.9 or newer recommended)
- [Git](https://git-scm.com/) (plugins sourcing)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (live grep)
- [fzf](https://github.com/junegunn/fzf) (fuzzy finder)


**Optional (only if you use these features):**
- **Zig / gcc / clang**: compile Tree-sitter parsers during install/update. 
  - If opting out, remove languages from treesitter parser sections in plugins.lua
- **Node.js + npm**: required for **Pyright** (Python LSP). 
  - If opting out, remove "pyright" from Mason `ensure_installed`in plugins.lua
- **Python + pip**: needed if you opt-in to install **black** and **pylint** via Mason  

<br>

## 🚀 Setup
1. **Install core tools**  

   - **Ubuntu (apt):**
     ```sh
     sudo apt update
     sudo apt install -y neovim git ripgrep fzf nodejs npm python3 python3-pip build-essential
     ```
     > `build-essential` provides `gcc/clang` for Tree-sitter compilation.  

   - **Windows (Scoop):**  
     Install [Scoop](https://scoop.sh/) first, then:  
     ```powershell
     scoop install neovim ripgrep fzf git
     ```
     **Optional (enable extra features):**
     ```powershell
     scoop install zig          # compile Tree-sitter parsers (optional)
     scoop install nodejs-lts   # needed for Pyright LSP (optional)
     scoop install python       # needed if you want black/pylint via Mason (optional)

2. Clone this repo into your Neovim config folder:  
   ```sh
   # macOS/Linux
   git clone https://github.com/Asim2/nvim_config.git ~/.config/nvim

   # Windows
   git clone https://github.com/Asim2/nvim_config.git $env:USERPROFILE\AppData\Local\nvim

   ```
    
3. Launch `nvim`. Plugins will auto-install on first launch.

<br>



<br>

## ⌨️ Keybindings

**Leader key:** `,`

#### General / Editing
- `<CR>` / `Enter` → clear search highlight (`:nohlsearch`)
- `<leader>o` → insert blank line **below** (stay in normal mode)
- `<leader>O` → insert blank line **above** (stay in normal mode)
- `<leader><Tab>` → toggle **relative line numbers** in buffer

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
  - Visual: `<S-A-j>` / `<S-A-k>` → move selection down / up
- **Indent**
  - Normal: `<S-A-h>` / `<S-A-l>` → outdent / indent
  - Visual: `<S-A-l>` / `<S-A-h>` → selection outdent / indent
