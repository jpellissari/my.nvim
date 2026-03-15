return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons', 'bullets-vim/bullets.vim' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    preset = 'obsidian',
    completions = {
      lsp = { enabled = true },
    },
    heading = {
      enabled = true,
      sign = true,
      icons = { '' },
      width = 'block',
    },
    indent = {
      enabled = true,
      per_level = 4,
    },
  },
  config = function(_, opts)
    require('render-markdown').setup(opts)

    -- Catppuccin Macchiato heading colors (H1 → H6: red → mauve)
    local h = {
      { fg = '#ed8796' }, -- red
      { fg = '#f5a97f' }, -- peach
      { fg = '#eed49f' }, -- yellow
      { fg = '#a6da95' }, -- green
      { fg = '#91d7e3' }, -- sky
      { fg = '#b7bdf8' }, -- lavender
    }
    for i, hl in ipairs(h) do
      vim.api.nvim_set_hl(0, 'RenderMarkdownH' .. i, { fg = hl.fg, bold = true })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH' .. i .. 'Bg', { bg = hl.fg, fg = '#000000' })
    end

    -- Inline elements (Catppuccin Macchiato)
    vim.api.nvim_set_hl(0, '@markup.strong', { fg = '#f5a97f', bold = true })       -- peach bold
    vim.api.nvim_set_hl(0, '@markup.italic', { fg = '#c6a0f6', italic = true })     -- mauve italic
    vim.api.nvim_set_hl(0, '@markup.strikethrough', { fg = '#6e738d', strikethrough = true }) -- overlay2
    vim.api.nvim_set_hl(0, 'RenderMarkdownCodeInline', { fg = '#8bd5ca', bg = '#1e2030' })   -- teal on mantle
    vim.api.nvim_set_hl(0, 'RenderMarkdownLink', { fg = '#8aadf4' })                -- blue
    vim.api.nvim_set_hl(0, 'RenderMarkdownInlineHighlight', { fg = '#24273a', bg = '#eed49f' }) -- yellow bg
  end,
}
