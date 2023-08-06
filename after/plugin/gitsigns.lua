require('gitsigns').setup {
  signs = {
    add          = { text = '+' },
    change       = { text = '~' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    vim.keymap.set('n', '<leader>hp', gs.prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
    vim.keymap.set('n', '<leader>hn', gs.next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
    vim.keymap.set('n', '<leader>hv', gs.preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
  end
}
