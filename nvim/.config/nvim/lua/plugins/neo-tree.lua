return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    config = function()
      require("neo-tree").setup({
        window = {
          mappings = {
            ["P"] = { "toggle_preview", config = { use_float = false } },
            ["l"] = "focus_preview",
            ["<C-u>"] = { "scroll_preview", config = {direction = 10} },
            ["<C-d>"] = { "scroll_preview", config = {direction = -10} },
          }
        },
        filesystem = {
          filtered_items = {
            visible = true,
            -- whether children of filtered parents should inherit their parent's highlight group
            children_inherit_highlights = true,
            hide_dotfiles = false,
          }
        }
      })
    end
  }
}
