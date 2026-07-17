-- Wraps snacks.statuscolumn to mark soft-wrapped continuation lines,
-- since Snacks intentionally leaves them blank (v:virtnum ~= 0).
local M = {}

function M.get()
  if vim.v.virtnum ~= 0 then
    if not (vim.wo.number or vim.wo.relativenumber) then
      return ''
    end
    return '  %=%#PellissariWrapMark#↳%* '
  end

  return require('snacks.statuscolumn').get()
end

return M
