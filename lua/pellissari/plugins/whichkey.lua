return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = {},
      },
      spec = {
        { '<leader>c', group = 'Code', mode = { 'n', 'x' } },
        { '<leader>f', group = 'Find' },
        { '<leader>g', group = 'Git' },
        { '<leader>h', group = 'Git Hunks', mode = { 'n', 'v' } },
        { '<leader>m', group = 'Markdown' },
        { '<leader>n', group = 'Notes' },
        { '<leader>o', group = 'Obsidian' },
        { '<leader>s', group = 'Search' },
        { '<leader>t', group = 'Toggle' },
      },
    },
  },
}
