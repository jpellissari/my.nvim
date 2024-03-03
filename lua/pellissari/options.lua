vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.completeopt = "menu,menuone,noselect"

vim.opt.confirm = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.updatetime = 50

vim.opt.colorcolumn = "80,120"

-- Added from kickstart
vim.opt.breakindent = true
vim.opt.showmode = false -- remove current mode, since it's already in status line

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Sets how neovim will display certain whitespace in the editor.
--  See :help 'list'
--  and :help 'listchars'
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = "split" -- substitutions appear in a split
