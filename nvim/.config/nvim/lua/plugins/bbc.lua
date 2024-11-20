return {
  "shumphrey/bbc.vim",
  ft = {"gitcommit", "markdown"},
  config = function()
    vim.cmd([[
      let g:jira_domain='https://jira.dev.bbc.co.uk/'
      au FileType gitcommit,markdown set completefunc=bbc#complete
    ]])
  end
}

