return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    dim = { enabled = true },
    explorer = { enabled = false },
    git = { enabled = true },
    gitbrowse = { enabled = true },
    images = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    zen = {
      enabled = true,
      win = {
        width = 100,
        backdrop = { blend = 20 },
      },
    },
  },
  config = function(_, opts)
    require('snacks').setup(opts)

    -- overlay2 (Catppuccin Macchiato), matches render-markdown.lua's muted elements
    vim.api.nvim_set_hl(0, 'PellissariWrapMark', { fg = '#6e738d' })

    -- override after Snacks sets its own, to mark soft-wrap continuation lines
    vim.o.statuscolumn = "%!v:lua.require'pellissari.helpers.statuscolumn'.get()"
  end,
  keys = {
    -- top-level
    { '<leader><space>', function() Snacks.picker.smart() end, desc = 'Smart Find Files' },
    { '<leader>,', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    { '<leader>/', function() Snacks.picker.grep() end, desc = 'Grep' },
    { '<leader>mz', function() Snacks.zen() end, desc = 'Zen Mode', ft = 'markdown' },

    -- find
    { '<leader>fb', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    { '<leader>fc', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, desc = 'Config Files' },
    { '<leader>ff', function() Snacks.picker.files() end, desc = 'Find Files' },
    { '<leader>fg', function() Snacks.picker.git_files() end, desc = 'Git Files' },
    { '<leader>fp', function() Snacks.picker.projects() end, desc = 'Projects' },
    { '<leader>fr', function() Snacks.picker.recent() end, desc = 'Recent' },

    -- git
    { '<leader>gb', function() Snacks.picker.git_branches() end, desc = 'Branches' },
    { '<leader>gd', function() Snacks.picker.git_diff() end, desc = 'Diff (Hunks)' },
    { '<leader>gf', function() Snacks.picker.git_log_file() end, desc = 'File Log' },
    { '<leader>gl', function() Snacks.picker.git_log() end, desc = 'Log' },
    { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Status' },

    -- search
    { '<leader>s/', function() Snacks.picker.search_history() end, desc = 'Search History' },
    { '<leader>sb', function() Snacks.picker.lines() end, desc = 'Buffer Lines' },
    { '<leader>sB', function() Snacks.picker.grep_buffers() end, desc = 'Grep Open Buffers' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
    { '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, desc = 'Buffer Diagnostics' },
    { '<leader>sg', function() Snacks.picker.grep() end, desc = 'Grep' },
    { '<leader>sh', function() Snacks.picker.help() end, desc = 'Help Pages' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
    { '<leader>sn', function() Snacks.picker.notifications() end, desc = 'Notifications' },
    { '<leader>sR', function() Snacks.picker.resume() end, desc = 'Resume' },
    { '<leader>ss', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },
    { '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'LSP Workspace Symbols' },
    { '<leader>sw', function() Snacks.picker.grep_word() end, desc = 'Word / Selection', mode = { 'n', 'x' } },

    -- LSP navigation
    { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' },
    { 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'Goto Declaration' },
    { 'gr', function() Snacks.picker.lsp_references() end, nowait = true, desc = 'References' },
    { 'gI', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation' },
    { 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto Type Definition' },
    { 'gai', function() Snacks.picker.lsp_incoming_calls() end, desc = 'Incoming Calls' },
    { 'gao', function() Snacks.picker.lsp_outgoing_calls() end, desc = 'Outgoing Calls' },
  },
}
