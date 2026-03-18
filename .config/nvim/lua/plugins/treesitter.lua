return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- Going back to the stable branch!
    build = ":TSUpdate",
    config = function()
        -- 1. Force the built-in Lua compiler to use your foolproof wrapper script
        require("nvim-treesitter.install").compilers = { vim.fn.expand("~/.local/bin/gcc64") }

        -- 2. Use the stable 'ensure_installed' setup
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "lua", "c", "cpp", "python", "rust" },
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
        })
    end,
}
