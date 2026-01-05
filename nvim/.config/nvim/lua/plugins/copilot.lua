return {
  {
    -- https://github.com/zbirenbaum/copilot.lua
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = false,
          auto_trigger = false,
        },
        panel = {
          enabled = true,
          auto_refresh = true,
          layout = {
            position = "right",
            width = 50,
          },
        },
      })
    end,
  },
  {
    -- Transforms copilot.lua into source for nvim-cmp
    -- https://github.com/zbirenbaum/copilot-cmp
    "zbirenbaum/copilot-cmp",
    config = function ()
      require("copilot_cmp").setup()
    end
  }
}
