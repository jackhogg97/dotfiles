return {
  -- Fuzzy finder
  -- https://github.com/nvim-telescope/telescope.nvim
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<C-f>", builtin.find_files, {})
    vim.keymap.set("n", "<leader>ff", builtin.git_files, {})
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
    vim.keymap.set("n", "<leader>bb", builtin.buffers, {})
  end,
}
