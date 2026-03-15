return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons', 'bullets-vim/bullets.vim' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    patterns = {
      markdown = {
        disable = false,
      },
    },
    preset = 'obsidian',
    completions = {
      lsp = { enabled = true },
    },
    heading = {
      enabled = true,
      sign = true,
      icons = { '' },
      width = 'full',
      border = true,
      border_virtual = true,
    },
    indent = {
      enabled = true,
      per_level = 4,
    },
  },
}
