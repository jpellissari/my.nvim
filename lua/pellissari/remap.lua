vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Tree view" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- better navigation
vim.keymap.set(
    { "n", "x" },
    "j",
    "v:count == 0 ? 'gj' : 'j'",
    { expr = true, silent = true, desc = "which_key_ignore" }
)
vim.keymap.set(
    { "n", "x" },
    "k",
    "v:count == 0 ? 'gk' : 'k'",
    { expr = true, silent = true, desc = "which_key_ignore" }
)
-- move line
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "which_key_ignore" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "which_key_ignore" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "which_key_ignore" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "which_key_ignore" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "which_key_ignore" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "which_key_ignore" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "which_key_ignore" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "which_key_ignore" })
vim.keymap.set("n", "n", "nzzzv", { desc = "which_key_ignore" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "which_key_ignore" })

vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "which_key_ignore" })

-- better indenting
vim.keymap.set("v", ">", ">gv", { desc = "which_key_ignore" })
vim.keymap.set("v", "<", "<gv", { desc = "which_key_ignore" })

vim.keymap.set("n", "<leader>qq", vim.cmd.qa, { desc = "quit all" })

vim.keymap.set("n", "Q", "<nop>", { desc = "which_key_ignore" })

-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "format buffer" })
vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ lsp_fallback = true })
end, { desc = "format buffer" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open [D]ocument diagnostics in quickfix list" })

--clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "which_key_ignore" })
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+yg_', { desc = "which_key_ignore" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "which_key_ignore" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "which_key_ignore" })

-- quickfix list
vim.keymap.set("n", "<C-j>", vim.cmd.cnext, { desc = "next on quickfix list" })
vim.keymap.set("n", "<C-k>", vim.cmd.cprev, { desc = "previous on quickfix list" })
-- location list
vim.keymap.set("n", "]l", vim.cmd.lnext, { desc = "next on location list" })
vim.keymap.set("n", "[l", vim.cmd.lprev, { desc = "previous on location list" })

vim.keymap.set("n", "<C-f>", "<cmd>!tmux neww tmux-fzfinderness.sh<CR>")
