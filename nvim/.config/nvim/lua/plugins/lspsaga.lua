return {
  'nvimdev/lspsaga.nvim',
  dependencies = {
    {'nvim-tree/nvim-web-devicons'},
    {'nvim-treesitter/nvim-treesitter'}
  },
  event = 'LspAttach',
  config = function()
    require('lspsaga').setup({
        ui = { border = 'rounded' },
        lightbulb = { enable = false },
        symbol_in_winbar = { enable = true }
    })
  end,
}

