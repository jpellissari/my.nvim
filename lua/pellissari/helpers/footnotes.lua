-- Footnote navigation (any markdown buffer — not vault-specific)
local M = {}

-- "bufnr:label" -> {row, col} origin to return to when jumping back from a definition
local footnote_origin = {}

-- All `[^label]` / `[^label]:` matches on a line, with byte spans and def/ref kind
local function footnote_matches(line)
  local matches = {}
  local pos = 1
  while true do
    local s, e, label = line:find('%[%^([^%]]+)%]', pos)
    if not s then
      break
    end
    table.insert(matches, { s = s, e = e, label = label, is_def = line:sub(e + 1, e + 1) == ':' })
    pos = e + 1
  end
  return matches
end

-- Match on `line` whose bracket span contains 0-indexed column `col`, or nil
local function match_at_col(line, col)
  for _, m in ipairs(footnote_matches(line)) do
    if col + 1 >= m.s and col + 1 <= m.e then
      return m
    end
  end
  return nil
end

-- All footnote matches in the buffer, as {row, col, label, is_def} (row 1-indexed, col 0-indexed)
local function all_footnote_matches(bufnr)
  local all = {}
  for i, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
    for _, m in ipairs(footnote_matches(line)) do
      table.insert(all, { row = i, col = m.s - 1, label = m.label, is_def = m.is_def })
    end
  end
  return all
end

local function find_definition(bufnr, label)
  for _, m in ipairs(all_footnote_matches(bufnr)) do
    if m.is_def and m.label == label then
      return m
    end
  end
  return nil
end

-- Nearest reference above `before_row`, else the first occurrence in the buffer
local function find_reference(bufnr, label, before_row)
  local best_above, first
  for _, m in ipairs(all_footnote_matches(bufnr)) do
    if not m.is_def and m.label == label then
      first = first or m
      if m.row < before_row then
        best_above = m
      end
    end
  end
  return best_above or first
end

local function land(row, col)
  vim.cmd "normal! m'"
  vim.api.nvim_win_set_cursor(0, { row, col })
  vim.cmd 'normal! zz'
end

-- `gf` on a footnote reference/definition jumps to its counterpart; otherwise passes through to native gf
function M.gf()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1], cursor[2]
  local m = match_at_col(vim.api.nvim_get_current_line(), col)

  if not m then
    vim.cmd 'normal! gf'
    return
  end

  local key = bufnr .. ':' .. m.label

  if m.is_def then
    local origin = footnote_origin[key]
    footnote_origin[key] = nil
    if origin then
      land(origin.row, origin.col)
      return
    end

    local ref = find_reference(bufnr, m.label, row)
    if not ref then
      vim.notify('No reference found for footnote ^' .. m.label, vim.log.levels.WARN)
      return
    end
    land(ref.row, ref.col)
  else
    local def = find_definition(bufnr, m.label)
    if not def then
      vim.notify('No definition found for footnote ^' .. m.label, vim.log.levels.WARN)
      return
    end

    footnote_origin[key] = { row = row, col = col }
    land(def.row, def.col)
  end
end

return M
