return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        -- Optional: This makes the UI look a bit cleaner
        layout_strategy = "horizontal",
        layout_config = { preview_width = 0.6 },
      },
      extensions = {
        fzf = {} -- Using empty brackets uses all the smart defaults
      }
    })

    -- This line is key: it tells Telescope to actually use the fzf engine
    telescope.load_extension("fzf")

    -- Minimal Keymaps
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
    vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Search Text" })
    vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "Open Buffers" })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help Tags' })
    -- Find absolutely everything
    vim.keymap.set("n", "<leader>fa", function()
        builtin.find_files({ hidden = true, no_ignore = true })
    end, { desc = "Find All Files" })
  end
}
