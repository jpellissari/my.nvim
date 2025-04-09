return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if you prefer nvim-web-devicons
  lazy = false,
  config = function()
    local oil = require 'oil'

    oil.setup {
      keymaps = {
        ['<BS>'] = { 'actions.parent', mode = 'n' },
        ['gd'] = {
          desc = 'Toggle file detail view',
          callback = function()
            OilFileDetail = not OilFileDetail
            if OilFileDetail then
              oil.set_columns { 'icon', 'permissions', 'size', 'mtime' }
            else
              oil.set_columns { 'icon' }
            end
          end,
        },
      },
    }

    -- vim.keymap.set('n', '<leader>e', '<cmd>Oil<CR>', { desc = 'Open oil' })
    vim.keymap.set('n', '<leader>e', function()
      if vim.bo.filetype == 'oil' then
        oil.close()
      else
        vim.cmd 'Oil'
      end
    end)
  end,
}
