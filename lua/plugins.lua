return {
    -- Theme and its settings
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({ flavour = "macchiato" })  -- Options: latte, frappe, macchiato, mocha
            vim.cmd("colorscheme catppuccin")
            vim.opt.termguicolors = true
        end,
    },
  
    -- Treesitter parser (required for mini.ai text objects?)
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "cpp", "python", "lua", "javascript", "typescript", "java"}, 
                highlight = { enable = true },
                indent = { enable = true }
            })
        end
    },

    -- Indentation-based text objects (`vii`, `vai`, `vI`, etc.)
    {
        "michaeljsmith/vim-indent-object"
    },

    -- Smart text objects (Treesitter for functions + loops/conditionals)
    {
        'echasnovski/mini.ai',
        event = 'VeryLazy',
        dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
        opts = function()
            local ai = require('mini.ai')
            return {
                n_lines = 500,
                custom_textobjects = {
                    -- Blocks, conditionals and loops (Treesitter-based)
                    o = ai.gen_spec.treesitter({
                        a = { '@block.outer', '@conditional.outer', '@loop.outer' },
                        i = { '@block.inner', '@conditional.inner', '@loop.inner' },
                    }, {}),
                    -- Functions and Classes (Treesitter-based)
                    f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
                    c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
                },
            }
        end,
        config = function(_, opts)
            require('mini.ai').setup(opts)
        end
    },

    -- Alignment tool (align text easily, useful for tables and code)
    {
        "echasnovski/mini.align",
        config = function()
            require("mini.align").setup()
        end
    },

    -- Vim-commentary replacement
    {
        "echasnovski/mini.comment",
        config = function()
            require("mini.comment").setup()
        end
    },

    -- Auto-pairing for brackets, quotes, etc.
    {
        "echasnovski/mini.pairs",
        config = function()
            require("mini.pairs").setup()
        end
    },

    -- Smarter word motions (improves `w`, `e`, `b`, `ge` to handle camelCase, snake_case, etc.)
    {
        "chrisgrieser/nvim-spider",
        keys = { "w", "e", "b", "ge" },
        config = function()
            vim.keymap.set({ "n", "x", "o" }, "<leader>w", "<cmd>lua require('spider').motion('w')<CR>")
            vim.keymap.set({ "n", "x", "o" }, "<leader>e", "<cmd>lua require('spider').motion('e')<CR>")
            vim.keymap.set({ "n", "x", "o" }, "<leader>b", "<cmd>lua require('spider').motion('b')<CR>")
            vim.keymap.set({ "n", "x", "o" }, "<leader>ge", "<cmd>lua require('spider').motion('ge')<CR>")
        end
    },

    -- Modern alternative to vim-surround (fork of tpope's vim-surround)
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end
    },

    -- LSP Support (for Python & More)
    {
        "neovim/nvim-lspconfig",                 -- Allows Neovim to use LSPs
    },

    {
        "williamboman/mason.nvim",           -- Mason: Installs LSPs, linters, formatters
        config = function()
            require("mason").setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",   -- Mason auto-configures LSPs
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        config = function()
            require("mason-lspconfig").setup({
              ensure_installed = { "pyright", "lua_ls" },  -- Add other LSPs as needed
            })

            -- Loop through all LSPs installed via Mason and configure them using lspconfig
            -- This ensures that any LSP you install later via Mason is automatically set up
            local lspconfig = require("lspconfig")
            for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
              lspconfig[server].setup({})
            end
        end,
    },

    -- Find files, Recent files, Open Buggers, Live Grep, Config files (see keybindings.lua)
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional for file icons
        config = function()
            require("fzf-lua").setup({
                -- Optional configuration
                winopts = {
                    height = 0.85,  -- Set window height
                    width = 0.80,   -- Set window width
                    preview = { layout = "vertical" },  -- Show preview vertically
                }
            })
        end,
    },


     -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- Completion from LSP
            "hrsh7th/cmp-buffer",   -- Completion from open buffers
            "hrsh7th/cmp-path",     -- Completion for file paths
            "hrsh7th/cmp-cmdline",  -- Completion for command-line mode
            "L3MON4D3/LuaSnip",     -- Snippet support
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },

    -- File tree
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup()
        end,
    },

    -- Dashboard
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },  -- Optional for icons
        config = function ()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            -- Add buttons
            dashboard.section.buttons.val = {
                dashboard.button("e", "📜 New File", ":ene <BAR> startinsert <CR>"),
                dashboard.button("f", "🔍 Find File", ":FzfLua files<CR>"),  -- fzf-lua instead of telescope
                dashboard.button("r", "📂 Recent Files", ":FzfLua oldfiles<CR>"),
                dashboard.button("s", "💾 Restore Last Session", ":lua require('persistence').load({ last = true })<CR>"),
                dashboard.button("q", "❌ Quit", ":qa<CR>"),
            }

            -- Apply the new config
            alpha.setup(dashboard.config)
        end
    },

    -- Session save and restore
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- Load before reading files
        config = function()
        require("persistence").setup({
            options = { "buffers", "curdir", "tabpages", "winsize" }
        })
        end
    },

    -- Neomux
    {
        "nikvdp/neomux",
        event = "VeryLazy", -- Load lazily to keep startup fast
    },

    -- Lua line status line
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    }

}


