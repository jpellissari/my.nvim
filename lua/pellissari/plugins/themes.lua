return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('catppuccin').setup {
        flavour = 'macchiato',
        color_overrides = {
          macchiato = {
            base = '#000000',
          },
        },
      }

      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}
