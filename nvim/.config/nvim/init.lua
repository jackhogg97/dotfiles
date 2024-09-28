require('plugins')
require('settings')
require('remap')

require('nvim-tmux-navigation').setup {
    disable_when_zoomed = true,
    keybindings = {
      left = "<C-h>",
      down = "<C-j>",
      up = "<C-k>",
      right = "<C-l>",
      last_active = "<C-\\>",
      next = "<C-Space>",
    }
}

-- bbc.vim
vim.cmd([[
  let g:jira_domain='https://jira.dev.bbc.co.uk/'
  au FileType gitcommit set completefunc=bbc#complete
]])

