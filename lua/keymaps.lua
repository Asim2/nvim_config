-- keymaps.lua (Custom Key Mappings)

-- ████████████████████████████
-- ███ General Settings & Editing ███
-- ████████████████████████████
--
-- leaders set in config/lazy.lua

-- Enable mouse, clipboard
vim.opt.clipboard = "unnamedplus"  -- Enable clipboard support
vim.opt.mouse = "a"  -- Enable mouse support in all modes

-- Clear search highlights when pressing Enter
vim.keymap.set("n", "<CR>", ":nohlsearch<CR>", { noremap = true, silent = true, desc = "Clear search highlight" })


-- Set tab width and use spaces instead of tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true  -- Converts tabs to spaces

-- These mappings allow adding a new blank line above or below without entering insert mode.
-- Useful when you want to format code without immediately typing.
vim.keymap.set("n", "<leader>o", "o<Esc>", { noremap = true, silent = true })  -- Insert blank line below and stay in normal mode
vim.keymap.set("n", "<leader>O", "O<Esc>", { noremap = true, silent = true })  -- Insert blank line above and stay in normal mode


-- Files
-- F4 → Copy current file's directory path to clipboard
vim.keymap.set("n", "<F4>", function()
    vim.fn.setreg("+", vim.fn.expand("%:p:h"))
end, { silent = true, desc = "Yank file directory path to clipboard" })

-- F5 → Copy full path of current file to clipboard
vim.keymap.set("n", "<F5>", function()
    vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { silent = true, desc = "Yank full file path to clipboard" })


-- ████████████████████████████
-- ███ Diagnostics (errors, warnings, etc 
-- ████████████████████████████

-- Toggle Diagnostics (<leader>l)
local diagnostics_enabled = true

function ToggleDiagnostics()
    diagnostics_enabled = not diagnostics_enabled

    vim.diagnostic.config({
        -- (paste diagnostics_enabled for what you want toggled with <leader>l)
        virtual_text = false, -- inline error warning text 
        signs = diagnostics_enabled, -- gutter signs e.g E, W
        underline = diagnostics_enabled,
        update_in_insert = false,
        severity_sort = true,
    })
    vim.notify("Diagnostics " .. (diagnostics_enabled and "enabled" or "disabled"))
end

vim.keymap.set("n", "<leader>l", ToggleDiagnostics, { desc = "Toggle all diagnostics" })



-- Show diagnostic popup automatically when holding cursor 
--                       (see comments below if toggle required)
vim.opt.updatetime = 250
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        -- if diagnostics_enabled then           -- uncomment if the cursor over popup should respect toggle too
            vim.diagnostic.open_float(nil, {
                focusable = false,
                border = "rounded",
                source = "always",
                scope = "cursor",
            })
        -- end                                   -- uncomment if the cursor over popup should respect toggle too
    end,
})



-- ████████████████████████████
-- ███ Terminal Settings ███
-- ████████████████████████████

vim.api.nvim_create_autocmd('TermOpen', {
    pattern = '*',
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end,
})

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Exit terminal mode" })




-- ████████████████████████████
-- ███ Line numbers
-- ████████████████████████████
-- Start with absolute line numbers
vim.opt.number = true
vim.opt.relativenumber = false  -- Ensure it starts as absolute

-- Toggle hybrid relative line numbers with <leader><Tab>
vim.keymap.set("n", "<leader><Tab>", function()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { noremap = true, silent = true })

-- see autocmds for switching off when leaving buffers



-- ████████████████████████████
-- ███ Tree ███
-- ████████████████████████████

-- Toggle file tree with Ctrl+t ; when NOT in tree
vim.keymap.set("n", "<C-t>", ":NvimTreeToggle<CR>", { noremap=true, silent=true })


-- Find the current file in the tree
vim.keymap.set("n", "<leader>t", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })


-- Keymaps for tree in focus
require("nvim-tree").setup({
    on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        -- 1) Load default keybindings first (on_attach func above overrides default nvim-tree keybindings)
        api.config.mappings.default_on_attach(bufnr)

        local function opts(desc)
            return { noremap = true, silent = true, buffer = bufnr, desc = "nvim-tree: " .. desc }
        end

        -- 3) Custom key mappings inside nvim-tree
        vim.keymap.set("n", "o", api.node.open.edit, opts("Open file"))
        vim.keymap.set("n", "i", api.node.open.horizontal, opts("Open in horizontal split"))
        vim.keymap.set("n", "s", api.node.open.vertical, opts("Open in vertical split"))
        vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("Change directory to root"))
        vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Go up one directory"))
        vim.keymap.set("n", "p", api.node.navigate.parent, opts("Jump cursor to parent directory"))
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Show help menu"))

        -- 3) **override** <C-t> to close the tree & return focus
        vim.keymap.set("n", "<C-t>", function()
          api.tree.close()
          vim.cmd("wincmd p")
        end, opts("close tree and go back"))

    end,
})



-- ████████████████████████████
-- ███ Workflowy-like Movements ███
-- ████████████████████████████
-- Move line(s) up/down in normal, insert, and visual modes
vim.keymap.set("n", "<S-A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<S-A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.keymap.set("i", "<S-A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
vim.keymap.set("i", "<S-A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
vim.keymap.set("v", "<S-A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Indentation shortcuts
vim.keymap.set("n", "<S-A-l>", ">>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-A-h>", "<<", { noremap = true, silent = true })
vim.keymap.set("v", "<S-A-l>", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-A-h>", "<gv", { noremap = true, silent = true })




-- ████████████████████████████
-- ███ FZF-Lua ███
-- ████████████████████████████
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", { desc = "Recent Files" })
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "Grep Text" })
vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua files cwd=~/.config/nvim<cr>", { desc = "Find Config Files" })
vim.keymap.set("n", "<leader>p", "<cmd>FzfLua commands<cr>", { desc = "Command Palette" })


-- ████████████████████████████
-- ███ splits  ███
-- ████████████████████████████
vim.keymap.set("n", "<C-J>", "<C-W><C-J>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", { noremap = true, silent = true })

-- Set splits to open below/right instead of above/left
vim.opt.splitbelow = true
vim.opt.splitright = true

-- split resizing
-- Increase/decrease window **width** with Ctrl+Shift+Left/Right
vim.keymap.set("n", "<C-Right>", ":vertical resize +5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Left>", ":vertical resize -5<CR>", { noremap = true, silent = true })

-- Increase/decrease window **height** with Ctrl+Shift+Up/Down
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { noremap=true, silent=true })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { noremap=true, silent=true })

-- Navigate between tabs using Alt+Left and Alt+Right
vim.keymap.set("n", "<A-Left>", ":tabprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Right>", ":tabnext<CR>", { noremap = true, silent = true })


-- ████████████████████████████
-- ███ Python Ruler ███
-- ████████████████████████████

-- Set up a 80-character ruler for Python files
vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = "python",
  callback = function()
    vim.opt_local.colorcolumn = "80"
    -- Apply a color for the ruler
    vim.cmd [[highlight ColorColumn guibg=#1e1e2e]]
  end,
})





-- Unused
-- vim.opt.autochdir = true -- automatic directory changes on every file switch, commented out to prevent conflicts with auto-session

