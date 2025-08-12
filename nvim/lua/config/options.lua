-- File handling
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

-- UI appearance and layout
vim.opt.cmdheight = 0
vim.opt.cursorline = true
vim.opt.laststatus = 3
vim.opt.number = true
vim.opt.numberwidth = 1
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 10
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 10

-- Performance optimizations
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 240
vim.opt.redrawtime = 1500
vim.opt.maxmempattern = 5000
vim.opt.history = 100
vim.opt.undolevels = 1000

-- Indentation and formatting
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.smartindent = true
vim.opt.tabstop = 2

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Command execution
vim.opt.inccommand = "split"
