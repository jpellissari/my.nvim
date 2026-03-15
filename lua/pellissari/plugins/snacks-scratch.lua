return {
  'folke/snacks.nvim',
  optional = true,
  keys = {
    {
      '<leader>np',
      function()
        Snacks.scratch {
          name = 'pomodoro',
          ft = 'markdown',
          icon = '🍅',
          title = 'Focus!!!',
          width = 80,
          height = 0.6,
          filekey = {
            id = 'pomo_scratch',
            cwd = false,
            branch = false,
            count = false,
          },
        }
      end,
      desc = '[N]otes [P]omodoro',
    },
    {
      '<leader>ni',
      function()
        vim.ui.select({
          '💡 Idea',
          '✅ Task',
        }, {
          prompt = '✏️ Quick Capture:',
          format_item = function(item)
            return item
          end,
        }, function(choice)
          if not choice then
            return
          end

          local is_idea = choice:match 'Idea'
          local type = is_idea and '💡 Idea' or '✅ Task'

          vim.ui.input({ prompt = type .. ': ' }, function(input)
            if not input or input == '' then
              return
            end

            local inbox_path = vim.fn.expand '~/notes/inbox.md'
            local date = os.date '%Y-%m-%d'
            local time = os.date '%H:%M'
            local line = string.format('%s — [[%s]] - %s', input, date, time)

            if not is_idea then
              line = '- [ ] ' .. line
            end

            -- Append to file
            local file = io.open(inbox_path, 'a')
            if file then
              file:write(line .. '\n')
              file:close()
              Snacks.notify.info(type .. ' captured to inbox')
            else
              Snacks.notify.error '❌ Failed to write to inbox.md'
            end
          end)
        end)
      end,
      desc = '[N]otes [I]dea (quick capture)',
    },
    {
      '<leader>nt',
      function()
        vim.ui.select({
          '💡 Idea',
          '✅ Task',
        }, {
          prompt = '✏️ Quick capture for today: ',
          format_item = function(item)
            return item
          end,
        }, function(choice)
          if not choice then
            return
          end

          local is_idea = choice:match 'Idea'
          local type = is_idea and '💡 Idea' or '✅ Task'

          vim.ui.input({
            prompt = type .. ': ',
            default = '',
          }, function(input)
            if not input or input == '' then
              return
            end

            local obsidian = require 'obsidian'
            local client = obsidian.get_client()

            local daily_note = client:today()
            local timestamp = os.date '%H:%M'
            local line = string.format('%s - *%s*', input, timestamp)
            if not is_idea then
              line = '- [ ] ' .. line
            end

            local file = io.open(tostring(daily_note.path), 'a')
            if file then
              file:write(line .. '\n')
              file:close()
              Snacks.notify.info(type .. ' captured to daily note!')
            else
              Snacks.notify.error '❌ Failed to write to daily note'
            end
          end)
        end)
      end,
      desc = '[N]otes [T]ask/today',
    },
  },
}
