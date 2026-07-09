local function augroup(name)
  return vim.api.nvim_create_augroup('pellissari_' .. name, { clear = true })
end

--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup 'highlight_yank',
  callback = function()
    vim.highlight.on_yank()
  end,
})

local relativeLineGroup = augroup 'relative-line'
vim.api.nvim_create_autocmd('InsertEnter', {
  desc = 'Set relative line when exit insert mode',
  group = relativeLineGroup,
  callback = function()
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  desc = 'Set relative line when exit insert mode',
  group = relativeLineGroup,
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup 'resize_splits',
  callback = function()
    vim.cmd 'tabdo wincmd ='
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup 'last_loc',
  callback = function()
    local exclude = { 'gitcommit' }
    local buf = vim.api.nvim_get_current_buf()
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end

    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'close_with_q',
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', vim.cmd.close, { buffer = event.buf, silent = true })
  end,
})

-- markdown-only keymaps
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'markdown_wrap',
  pattern = 'markdown',
  callback = function(event)
    vim.wo.conceallevel = 3

    vim.keymap.set('n', '<leader>tw', function()
      local enabled = not vim.wo.wrap
      vim.wo.wrap = enabled
      vim.wo.conceallevel = enabled and 3 or 0
    end, { buffer = event.buf, desc = '[T]oggle [w]rap' })

    vim.keymap.set('n', 'gf', require('pellissari.helpers.notes').footnote_gf, { buffer = event.buf, desc = 'Jump to/from footnote' })
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'OilActionsPost',
  callback = function(event)
    if event.data.actions[1].type == 'move' then
      Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
    end
  end,
})

vim.api.nvim_create_autocmd('BufWinLeave', {
  group = augroup 'autosave_notes',
  callback = function(event)
    require('pellissari.helpers.notes').auto_save(event)
  end,
})

-- Enable spellcheck (en_us + pt_br) for prose filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'spell_prose',
  pattern = { 'markdown', 'gitcommit', 'text' },
  callback = function()
    vim.wo.spell = true
  end,
})
