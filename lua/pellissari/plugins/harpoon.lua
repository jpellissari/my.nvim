return {
  'ThePrimeagen/harpoon',
  otps = {},
  config = function()
    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'
    --
    vim.keymap.set('n', '<leader>a', mark.add_file, { desc = 'Harpoon: Add file' })
    vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu, { desc = 'Harpoon: Quick menu' })
    for i = 1, 4, 1 do
      vim.keymap.set('n', '<leader>' .. i, function()
        ui.nav_file(i)
      end, { desc = 'which_key_ignore' })
    end
  end,
}
