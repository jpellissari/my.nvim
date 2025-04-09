return {
  {
    'mbbill/undotree',
    otps = {},
  },

  vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'undotree' }),
}
