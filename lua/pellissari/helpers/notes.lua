local M = {}

M.footnote_gf = require('pellissari.helpers.footnotes').footnote_gf

local NOTES_PATH = '~/notes'
local INBOX_PATH = '00_INBOX.md'
local WORK_LOG_PATH = '00_WORK_LOG.md'
local CURRENT_FOCUS_PATH = '00_CURRENT_FOCUS.md'

local notes_dir_cache

--- Get expanded notes dir (cached, path never changes at runtime)
--- @return string
local function get_notes_dir()
  notes_dir_cache = notes_dir_cache or vim.fn.expand(NOTES_PATH)
  return notes_dir_cache
end

--- Resolve a note's absolute path from a path relative to the notes dir
--- @param relative_path string
--- @return string
local function resolve_note_path(relative_path)
  return vim.fs.joinpath(get_notes_dir(), relative_path)
end

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
    tostring(get_note(CURRENT_FOCUS_PATH).path),
    tostring(get_note(WORK_LOG_PATH).path),
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

--- Open a known note by name. See :Notes completion for valid names.
---@param name string
local function open_named_note(name)
  local targets = {
    inbox = INBOX_PATH,
    worklog = WORK_LOG_PATH,
    focus = CURRENT_FOCUS_PATH,
    home = 'home.md',
  }
  local relative_path = targets[name]
  assert(relative_path, 'unknown note: ' .. tostring(name))
  vim.cmd.edit(resolve_note_path(relative_path))
end

vim.api.nvim_create_user_command('Notes', function(cmd_opts)
  open_named_note(cmd_opts.args)
end, {
  nargs = 1,
  complete = function()
    return { 'inbox', 'worklog', 'focus', 'home' }
  end,
})

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
