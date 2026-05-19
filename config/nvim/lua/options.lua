local opt = vim.opt

opt.number = true
opt.signcolumn = "yes"
opt.encoding = "utf-8"
opt.termguicolors = true
opt.background = "dark"

opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.textwidth = 100

opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true

opt.clipboard = "unnamedplus"
opt.hidden = true
opt.undofile = false
opt.backup = false
opt.swapfile = false

opt.foldmethod = "indent"
opt.foldenable = false

opt.whichwrap:append("<,>,h,l")
