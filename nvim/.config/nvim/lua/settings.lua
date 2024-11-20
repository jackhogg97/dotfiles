local set = vim.opt

set.fileencoding = 'utf-8'

set.expandtab = true
set.smarttab = true
set.smartindent = true
set.tabstop = 2
set.shiftwidth = 2

set.splitbelow = true
set.splitright = true

set.termguicolors = true
set.relativenumber = true
set.number = true

set.hidden = true
set.swapfile = false

-- Reserve space for diagnostic icons
set.signcolumn = 'yes'
-- Start scrolling 5 lines from bottom
set.scrolloff = 5
set.scrolljump = 5
set.scrollback = 5

-- Bash style command tab completion
set.wildmode = 'longest,list,full'
-- Persist undo history
set.undofile = true

-- z= for spelling suggestions
set.spelllang = 'en_gb'
