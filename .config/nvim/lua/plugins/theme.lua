return {
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- Load immediately
    priority = 1000, -- Load before other plugins
    config = function()
      -- Apply the theme here
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
}
