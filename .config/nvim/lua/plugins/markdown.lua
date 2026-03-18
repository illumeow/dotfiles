return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    keys = {
        {
        "<leader>md",
        function()
            require('render-markdown').toggle()
        end,
        desc = "Toggle Render Markdown",
        },
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
}
