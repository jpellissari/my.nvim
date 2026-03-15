local M = {}

local function obsidian_client()
  require('lazy').load { plugins = { 'obsidian.nvim' } }
  return require('obsidian').get_client()
end

-- Format a capture line for the inbox: `input — [[YYYY-MM-DD]] - HH:MM`
local function format_inbox_line(input, is_task)
  local date = os.date '%Y-%m-%d'
  local time = os.date '%H:%M'
  local line = string.format('%s — [[%s]] - %s', input, date, time)
  if is_task then
    line = '- [ ] ' .. line
  end
  return line
end

-- Format a capture line for the daily note: `input - *HH:MM*`
local function format_daily_line(input, is_task)
  local time = os.date '%H:%M'
  local line = string.format('%s - *%s*', input, time)
  if is_task then
    line = '- [ ] ' .. line
  end
  return line
end

function M.append_daily(input, is_task)
  local text = format_daily_line(input, is_task)
  obsidian_client():today():save {
    update_content = function(lines)
      table.insert(lines, text)
      return lines
    end,
  }
end

function M.append_inbox(input, is_task)
  local text = format_inbox_line(input, is_task)
  local client = obsidian_client()
  local inbox = require('obsidian.note').from_file(client.dir / '0 - inbox.md')
  inbox:save {
    update_content = function(lines)
      table.insert(lines, text)
      return lines
    end,
  }
end

function M.open_pomodoro()
  local client = obsidian_client()
  local note = require('obsidian.note').from_file(client.dir / 'pomodoro.md')
  client:open_note(note)
end

return M
