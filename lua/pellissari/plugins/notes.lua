return {
  {
    'folke/zen-mode.nvim',
    opts = {
      plugins = {
        alacritty = {
          enabled = false,
          font = '16', -- font size
        },
      },
    },
  },
  {
    'folke/snacks.nvim',
    optional = true,
    keys = {
      {
        '<leader>ni',
        function()
          vim.ui.select({ '💡 Idea', '✅ Task' }, {
            prompt = '✏️ Quick Capture:',
            format_item = function(item)
              return item
            end,
          }, function(choice)
            if not choice then
              return
            end

            local is_task = not choice:match 'Idea'
            local label = is_task and '✅ Task' or '💡 Idea'

            vim.ui.input({ prompt = label .. ': ' }, function(input)
              if not input or input == '' then
                return
              end
              require('pellissari.helpers.notes').append_inbox(input, is_task)
              Snacks.notify.info(label .. ' captured to inbox')
            end)
          end)
        end,
        desc = '[N]otes [I]dea (quick capture)',
      },
      {
        '<leader>nt',
        function()
          vim.ui.select({ '💡 Idea', '✅ Task' }, {
            prompt = '✏️ Quick capture for today: ',
            format_item = function(item)
              return item
            end,
          }, function(choice)
            if not choice then
              return
            end

            local is_task = not choice:match 'Idea'
            local label = is_task and '✅ Task' or '💡 Idea'

            vim.ui.input({ prompt = label .. ': ', default = '' }, function(input)
              if not input or input == '' then
                return
              end
              require('pellissari.helpers.notes').append_daily(input, is_task)
              Snacks.notify.info(label .. ' captured to daily note!')
            end)
          end)
        end,
        desc = '[N]otes [T]ask/today',
      },
      {
        '<leader>nh',
        function()
          require('pellissari.helpers.notes').open_note 'home.md'
        end,
        desc = '[N]otes [H]ome (dashboard)',
      },
    },
  },
}
