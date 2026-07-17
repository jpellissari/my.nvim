return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = false,
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
  },
  config = function()
    require('obsidian').setup {
      workspaces = {
        {
          name = 'work',
          path = '/home/joaoh/notes',
        },
        {
          name = 'personal',
          path = '/home/joaoh/pnotes',
        },
      },

      ui = { enable = false }, -- Disable UI favoring render-markdown

      daily_notes = {
        folder = '/periodic/daily',
        date_format = '%Y-%m-%d',
        alias_format = '%B %-d, %Y',
        default_tags = { 'daily-notes' },
        -- template = 'daily.md',
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      mappings = {
        -- Buffer-local mappings (only available in vault notes)
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ['gf'] = {
          action = function()
            return require('obsidian').util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ['<leader>ch'] = {
          action = function()
            return require('obsidian').util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ['<cr>'] = {
          action = function()
            return require('obsidian').util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },

        ['<leader>oy'] = {
          action = '<cmd>ObsidianYesterday<CR>',
          opts = { desc = 'Open yesterday', buffer = true },
        },

        ['<leader>oo'] = {
          action = '<cmd>ObsidianQuickSwitch<CR>',
          opts = { desc = 'Obsidian QuickSwitch', buffer = true },
        },

        ['<leader>os'] = {
          action = '<cmd>ObsidianSearch<CR>',
          opts = { desc = 'Obsidian Search', buffer = true },
        },
      },

      note_id_func = function(title)
        local suffix = ''
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return suffix
      end,

      new_notes_location = 'current_dir',

      -- This will keep links as [[Foo bar]]
      wiki_link_func = 'use_alias_only',

      templates = {
        folder = 'templates',
        date_format = '%Y-%m-%d',
        time_format = '%H:%M',
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {
          long_date = function()
            return os.date '%A - %B %d, %Y'
          end,
        },
      },
    }

    -- Global keybinding for today's note and inbox
    -- vim.keymap.set('n', '<leader>ot', '<cmd>ObsidianToday<CR>', { desc = "Open Today's note" })

    -- vim.keymap.set('n', '<leader>oi', require('pellissari.helpers.notes').open_inbox, { desc = 'Open Inbox note' })
  end,
}
