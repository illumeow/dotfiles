return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "folke/neoconf.nvim",
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "luvit-meta/library", words = { "vim%.uv" } },
                },
            },
        },
        { "Bilal2453/luvit-meta", lazy = true },
    },
    config = function()
        require("neoconf").setup()
        require("mason").setup()

        local servers = {
            clangd = {},  -- C/C++
            pyright = {}, -- Python
            lua_ls = {},  -- lua
        }

        local on_attach = function(_, bufnr)
            local nmap = function(keys, func, desc)
                if desc then desc = 'LSP: ' .. desc end
                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            -- Keymaps 
            nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            nmap('gd', "<Cmd>Lspsaga peek_definition<Cr>", '[G]oto [D]efinition')
            nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
            nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
            nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
            nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
            nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
            nmap('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, '[W]orkspace [L]ist Folders')
            nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
            nmap('<leader>rn', "<Cmd>Lspsaga rename<Cr>", '[R]e[n]ame')
            nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
            nmap('gr', "<Cmd>Lspsaga finder<Cr>", '[G]oto [R]eferences')
            nmap('<Leader>da', require "telescope.builtin".diagnostics , '[D]i[A]gnostics')

            nmap("<space>f", function() vim.lsp.buf.format { async = true } end, "[F]ormat code")
        end

        vim.diagnostic.config({
            virtual_text = { prefix = '●' },
            severity_sort = true,
            float = {
                border = 'rounded',
                source = 'always', 
            },
        })

        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        
        require("mason-lspconfig").setup({
            ensure_installed = vim.tbl_keys(servers),
            handlers = {
                function(server_name) 
                    require("lspconfig")[server_name].setup {
                        settings = servers[server_name],
                        on_attach = on_attach,
                        capabilities = capabilities,
                    }
                end,
            }
        })
    end
}
