return {
  {
    -- Language parser for enhanced syntax highlighting
    -- https://github.com/nvim-treesitter/nvim-treesitter
    "nvim-treesitter/nvim-treesitter",
    -- build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "lua", "vimdoc" },
        sync_install = false,
        auto_install = true,
        italics = false,
        highlight = {
          enable = true,
        },
      })
    end,
  },
  {
    -- Displays function context
    -- https://github.com/nvim-treesitter/nvim-treesitter-context
    "nvim-treesitter/nvim-treesitter-context"
  }
}
