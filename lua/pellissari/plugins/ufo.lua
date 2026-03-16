return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  event = 'BufReadPost',
  init = function()
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  opts = {
    provider_selector = function(_, filetype, _)
      local ft_map = {
        lua = { 'treesitter', 'indent' },
        go = { 'treesitter', 'indent' },
        typescript = { 'treesitter', 'indent' },
        typescriptreact = { 'treesitter', 'indent' },
        javascript = { 'treesitter', 'indent' },
        markdown = { 'treesitter', 'indent' },
      }
      return ft_map[filetype] or { 'lsp', 'indent' }
    end,
  },
  keys = {
    { 'zR', function() require('ufo').openAllFolds() end, desc = 'Open All Folds' },
    { 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close All Folds' },
    { 'zr', function() require('ufo').openFoldsExceptKinds() end, desc = 'Open Folds Except Kinds' },
    { 'zm', function() require('ufo').closeFoldsWith() end, desc = 'Close Folds With' },
    {
      'K',
      function()
        local ufo = require 'ufo'
        local winid = ufo.peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end,
      desc = 'Peek Fold / Hover',
    },
  },
}
