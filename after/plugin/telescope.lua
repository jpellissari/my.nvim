local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Search Files" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search Files" })
-- vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Search Git Files " })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [h]elp pages" })
vim.keymap.set("n", "<leader>sw", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") });
end, { desc = "[S]earch [W]ord" })
