return {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
        local rainbow_delimiters = require("rainbow-delimiters")
        require("rainbow-delimiters.setup").setup({
            strategy = {
                -- [''] is the default strategy for all languages
                [''] = rainbow_delimiters.strategy['global'],
                -- 'local' is faster for specific languages if files get huge
                vim = rainbow_delimiters.strategy['local'],
            },
            query = {
                [''] = 'rainbow-delimiters',
                lua = 'rainbow-blocks',
                -- You can add specific queries for web development here:
                -- javascript = 'rainbow-delimiters-react',
                -- tsx = 'rainbow-parens',
                -- html = 'rainbow-tags',
            },
            priority = {
                [''] = 110,
                lua = 210,
            },
            highlight = {
                'RainbowDelimiterYellow',
                'RainbowDelimiterViolet',
                'RainbowDelimiterBlue',
            },
        })
    end
}
