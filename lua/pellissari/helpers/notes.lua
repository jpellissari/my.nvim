local M = {}

function M.append_daily(text)
  require('lazy').load { plugins = { 'obsidian.nvim' } }
  require('obsidian').get_client():today():save {
    update_content = function(lines)
      table.insert(lines, text)
      return lines
    end,
  }
end

function M.append_inbox(text)
  require('lazy').load { plugins = { 'obsidian.nvim' } }
  local client = require('obsidian').get_client()
  local inbox = require('obsidian.note').from_file(client.dir / '0 - inbox.md')
  inbox:save {
    update_content = function(lines)
      table.insert(lines, text)
      return lines
    end,
  }
end

return M
