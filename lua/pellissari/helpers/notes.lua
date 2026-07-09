local M = {}

M.footnote_gf = require('pellissari.helpers.footnotes').footnote_gf

local INBOX_PATH = 'inbox.md'
local POMODORO_PATH = 'pomodoro.md'

--- Return the active obsidian client, asserting one exists.
---@return table
local function get_client()
  local client = require('obsidian').get_client()
  assert(client, 'obsidian client not available')
  return client
end

--- Load a note by filename relative to the vault.
---@param filename string
---@return table
local function get_note(filename)
  return require('obsidian.note').from_file(get_client().dir / filename)
end

--- Paths of notes that should autosave when their buffer is closed.
---@return string[]
local function autosave_paths()
  return {
    tostring(get_note(INBOX_PATH).path),
    tostring(get_note(POMODORO_PATH).path),
    tostring(get_client():today().path),
  }
end

---@class FormatLineOpts
---@field input string
---@field add_date? boolean
---@field is_task? boolean

--- Format a bullet line with a timestamp (and optional date link).
---@param opts FormatLineOpts
---@return string
local function format_line(opts)
  local prefix = opts.is_task and '- [ ] ' or '- '
  local suffix

  if opts.add_date then
    suffix = string.format(' - [[%s]] %s', os.date '%Y-%m-%d', os.date '%H:%M')
  else
    suffix = string.format(' - %s', os.date '%H:%M')
  end

  return prefix .. opts.input .. suffix
end

--- Append a line to a note and save it.
---@param note table
---@param text string
local function append_line(note, text)
  note:save {
    update_content = function(lines)
      table.insert(lines, text)
      return lines
    end,
  }
end

--- Append a line to today's daily note.
---@param input string
---@param is_task? boolean
function M.append_daily(input, is_task)
  local text = format_line { input = input, is_task = is_task }
  append_line(get_client():today(), text)
end

--- Append a line to the inbox note.
---@param input string
---@param is_task? boolean
function M.append_inbox(input, is_task)
  local text = format_line { input = input, add_date = true, is_task = is_task }
  append_line(get_note(INBOX_PATH), text)
end

--- Open a note by filename relative to the vault.
---@param relative_path string
function M.open_note(relative_path)
  local note = get_note(relative_path)
  get_client():open_note(note)
end

--- Open the inbox note.
function M.open_inbox()
  M.open_note(INBOX_PATH)
end

--- Open the pomodoro note.
function M.open_pomodoro()
  M.open_note(POMODORO_PATH)
end

--- Absolute path of the pomodoro note.
---@return string
function M.pomodoro_path()
  return tostring(get_note(POMODORO_PATH).path)
end

--- Save the buffer if it's a tracked note and has unsaved changes.
---@param event table
function M.auto_save(event)
  local path = vim.api.nvim_buf_get_name(event.buf)

  if vim.bo[event.buf].modified and vim.tbl_contains(autosave_paths(), path) then
    vim.api.nvim_buf_call(event.buf, function()
      vim.cmd 'silent! write'
    end)
  end
end

return M
