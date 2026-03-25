-- Globol Settings --
vim.opt.showmode = false
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wildmenu = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.autoread = true
vim.opt.title = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.updatetime = 50
vim.opt.mouse = "a"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('$HOME/.local/share/nvim/undo')
vim.opt.exrc = true
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.scrolloff = 3
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

-- Buffer Settings --
vim.b.fileencoding = "utf-8"

-- Global Settings --
vim.g.mapleader = " "

-- Key mappings --

vim.keymap.set("n", "<A-Tab>", "<cmd>bNext<CR>") 
vim.keymap.set("n", "<leader>bc", "<cmd>bd<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set({ "v", "n" }, "<leader>y", "\"+y")
vim.keymap.set("i", "jj", "<Esc>")

-- Easier window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })

vim.keymap.set({"n", "v"}, "<C-b>", [[<cmd>Neotree toggle<CR>]])
