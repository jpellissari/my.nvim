vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Tree view" })

-- better navigation
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "which_key_ignore" })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "which_key_ignore" })
-- move line
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "which_key_ignore" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "which_key_ignore" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "which_key_ignore" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "which_key_ignore" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "which_key_ignore" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "which_key_ignore" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "which_key_ignore" })
vim.keymap.set("n", "<C-u>", "<C-u>zz",{ desc = "which_key_ignore" } )
vim.keymap.set("n", "n", "nzzzv", { desc = "which_key_ignore" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "which_key_ignore" })

vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "which_key_ignore" })

-- better indenting
vim.keymap.set("v", ">", ">gv", { desc = "which_key_ignore" })
vim.keymap.set("v", "<", "<gv", { desc = "which_key_ignore" })

vim.keymap.set("n", "<leader>qq", vim.cmd.qa, { desc = "quit all" })

vim.keymap.set("n", "Q", "<nop>", { desc = "which_key_ignore" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "format buffer" })


--clipboard
vim.keymap.set({"n", "v"}, "<leader>y", '"+y', { desc = "which_key_ignore" })
vim.keymap.set({"n", "v"}, "<leader>Y", '"+yg_', { desc = "which_key_ignore" })
vim.keymap.set({"n", "v"}, "<leader>P", '"+P', { desc = "which_key_ignore" })
vim.keymap.set({"n", "v"}, "<leader>p", '"+p', { desc = "which_key_ignore" })
