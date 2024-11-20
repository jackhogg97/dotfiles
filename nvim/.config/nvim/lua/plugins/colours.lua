return {
  -- Colourscheme
  -- https://github.com/rebelot/kanagawa.nvim
  "rebelot/kanagawa.nvim",
  lazy = false,
  opts = {
    compile = false,             -- enable compiling the colorscheme
    undercurl = true,            -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = false },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,         -- do not set background color
    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
    colors = {                   -- add/modify theme and palette colors
      palette = {
        waveRed = "#87454d"
      },
      theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function(colors) -- add/modify highlights
      return {}
    end,
    theme = "wave",              -- Load "wave" theme when 'background' option is not set
    background = {               -- map the value of 'background' option to a theme
      dark = "wave",           -- try "dragon" !
      light = "lotus"
    }
  },
  config = function()
    vim.cmd([[colorscheme kanagawa]])
  end,
}