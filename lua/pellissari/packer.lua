-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    use({
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-ui-select.nvim" },
            { "nvim-telescope/telescope-ui-select.nvim" },
        },
    })

    use({
        "rose-pine/neovim",
        as = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine")
        end,
    })

    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
    use("theprimeagen/harpoon")
    use("mbbill/undotree")
    use("folke/which-key.nvim")
    use("lewis6991/gitsigns.nvim")
    use("lukas-reineke/indent-blankline.nvim")

    use({
        "folke/trouble.nvim",
        requires = {
            { "nvim-tree/nvim-web-devicons" },
        },
    })

    -- Highlight todo, notes, etc in comments
    use({
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("todo-comments").setup()
        end,
    })

    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })

    use({
        "epwalsh/obsidian.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })

    use({ -- Collection of various small independent plugins/modules
        "echasnovski/mini.nvim",
        config = function()
            -- Better Around/Inside textobjects
            --
            -- Examples:
            --  - va)  - [V]isually select [A]round [)]parenthen
            --  - yinq - [Y]ank [I]nside [N]ext [']quote
            --  - ci'  - [C]hange [I]nside [']quote
            require("mini.ai").setup({ n_lines = 500 })

            -- Add/delete/replace surroundings (brackets, quotes, etc.)
            --
            -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
            -- - sd'   - [S]urround [D]elete [']quotes
            -- - sr)'  - [S]urround [R]eplace [)] [']
            require("mini.surround").setup()

            -- Simple and easy statusline.
            --  You could remove this setup call if you don't like it,
            --  and try some other statusline plugin
            require("mini.statusline").setup()

            -- ... and there is more!
            --  Check out: https://github.com/echasnovski/mini.nvim
        end,
    })

    use({ -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        requires = {
            -- Automatically install LSPs and related tools to stdpath for neovim
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Useful status updates for LSP.
            {
                "j-hui/fidget.nvim",
                config = function()
                    require("fidget").setup()
                end,
            },
        },
    })

    use({
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                notify_on_error = true,
                formatters_by_ft = {
                    lua = { "stylua" },
                    -- Conform can also run multiple formatters sequentially
                    -- python = { "isort", "black" },
                    --
                    -- You can use a sub-list to tell conform to run *until* a formatter
                    -- is found.
                    javascript = { { "prettierd", "prettier" } },
                    typescript = { { "prettierd", "prettier" } },
                },
            })
        end,
    })

    -- use({
    --     "mfussenegger/nvim-lint",
    --     config = function()
    --         require("lint").linters_by_ft = {
    --             typescript = { "eslint" },
    --         }
    --     end,
    -- })

    use({ -- Autocompletion
        "hrsh7th/nvim-cmp",
        requires = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                "L3MON4D3/LuaSnip",
                run = "make install_jsregexp",
            },
            "saadparwaiz1/cmp_luasnip",

            -- Adds other completion capabilities.
            --  nvim-cmp does not ship with all sources by default. They are split
            --  into multiple repos for maintenance purposes.
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",

            -- If you want to add a bunch of pre-configured snippets,
            --    you can use this plugin to help you. It even has snippets
            --    for various frameworks/libraries/etc. but you will have to
            --    set up the ones that are useful for you.
            -- "rafamadriz/friendly-snippets",
        },
        config = function()
            -- See `:help cmp`
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            luasnip.config.setup({})

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = "menu,menuone,noinsert" },

                -- For an understanding of why these mappings were
                -- chosen, you will need to read `:help ins-completion`
                --
                -- No, but seriously. Please read `:help ins-completion`, it is really good!
                mapping = cmp.mapping.preset.insert({
                    -- Select the [n]ext item
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    -- Select the [p]revious item
                    ["<C-p>"] = cmp.mapping.select_prev_item(),

                    -- Accept ([y]es) the completion.
                    --  This will auto-import if your LSP supports it.
                    --  This will expand snippets if the LSP sent a snippet.
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),

                    -- Manually trigger a completion from nvim-cmp.
                    --  Generally you don't need this, because nvim-cmp will display
                    --  completions whenever it has completion options available.
                    ["<C-Space>"] = cmp.mapping.complete({}),

                    -- Think of <c-l> as moving to the right of your snippet expansion.
                    --  So if you have a snippet that's like:
                    --  function $name($args)
                    --    $body
                    --  end
                    --
                    -- <c-l> will move you to the right of each of the expansion locations.
                    -- <c-h> is similar, except moving you backwards.
                    ["<C-l>"] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { "i", "s" }),
                    ["<C-h>"] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { "i", "s" }),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                },
            })
        end,
    })
    -- use {
    --     'VonHeikemen/lsp-zero.nvim',
    --     branch = 'v2.x',
    --     requires = {
    --         -- LSP Support
    --         { 'neovim/nvim-lspconfig' },             -- Required
    --         { 'williamboman/mason.nvim' },           -- Optional
    --         { 'williamboman/mason-lspconfig.nvim' }, -- Optional
    --
    --         -- Autocompletion
    --         { 'hrsh7th/nvim-cmp' },     -- Required
    --         { 'hrsh7th/cmp-nvim-lsp' }, -- Required
    --         { 'L3MON4D3/LuaSnip' },     -- Required
    --         { 'folke/neodev.nvim' },
    --
    --         { 'jose-elias-alvarez/null-ls.nvim' }
    --     }
    -- }
end)
