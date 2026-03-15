-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set({ 'n', 'i' }, '<C-c>', '<Esc>', { noremap = true })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'Next quickfix item' })
vim.keymap.set('n', '[q', vim.cmd.cprev, { desc = 'Previous quickfix item' })

-- NOTE: Some terminals have coliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })
-- better navigation

-- Custom (out of kickstart)
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = 'which_key_ignore' })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = 'which_key_ignore' })
-- move line
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'which_key_ignore' })
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'which_key_ignore' })

vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'which_key_ignore' })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'which_key_ignore' })
vim.keymap.set('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'which_key_ignore' })
vim.keymap.set('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'which_key_ignore' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'which_key_ignore' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'which_key_ignore' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'which_key_ignore' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'which_key_ignore' })

-- better indenting
vim.keymap.set('v', '>', '>gv', { desc = 'which_key_ignore' })
vim.keymap.set('v', '<', '<gv', { desc = 'which_key_ignore' })

vim.keymap.set('n', '<leader>qq', vim.cmd.qa, { desc = 'quit all' })

--clipboard
-- vim.keymap.set({"n", "v"}, "<leader>y", '"+y', { desc = "which_key_ignore" })
-- vim.keymap.set({"n", "v"}, "<leader>Y", '"+yg_', { desc = "which_key_ignore" })
-- vim.keymap.set({"n", "v"}, "<leader>P", '"+P', { desc = "which_key_ignore" })
-- vim.keymap.set({"n", "v"}, "<leader>p", '"+p', { desc = "which_key_ignore" })

