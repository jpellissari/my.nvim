local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

vim.keymap.set("n", "<leader>a", mark.add_file, {desc = "HARPOON: Add buffer"})
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, {desc = "HARPOON: Quick menu"})

vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, {desc = "HARPOON: 1 file"})
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, {desc = "HARPOON: 2 file"})
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, {desc = "HARPOON: 3 file"})
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, {desc = "HARPOON: 4 file"})
