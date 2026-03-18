return {
    {
        'echasnovski/mini.ai',
        config = function()
            require('mini.ai').setup()
        end,
    },
    {
        "echasnovski/mini.comment",
        config = function()
            require('mini.comment').setup()
        end,
    },
    { 'nvim-mini/mini.icons', version = '*' },
}
