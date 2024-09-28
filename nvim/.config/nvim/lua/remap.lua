vim.g.mapleader = " "

vim.keymap.set("n", "<leader>e", ":Explore<CR>")
vim.keymap.set("n", "<leader>n", vim.cmd.bnext)
vim.keymap.set("n", "<leader>p", vim.cmd.bprev)
vim.keymap.set("n", "<leader>q", vim.cmd.bwipeout)

-- Yank to system register
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+y")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- replace %% with file path of current buffer
vim.api.nvim_set_keymap('c', '%%', '<C-R>=fnameescape(expand("%:h")).."/"<CR>', {noremap = true, silent = true})

-- buffers
vim.keymap.set("n", "tt", ":ls<CR>:b<Space>")
