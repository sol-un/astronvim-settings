local M = {}

M.CURRENT = nil

M.highlight_current = function(session)
  if session ~= M.CURRENT then return session end

  return " " .. session
end

---@param action "read"|"delete"
M.read_or_delete = function(action)
  local ms = require('mini.sessions')

  vim.ui.select(vim.tbl_keys(ms.detected), {
    format_item = M.highlight_current,
  }, function(session)
    if session then ms[action](session) end
  end)
end

M.get_session_name = function()
  local name = vim.fn.getcwd()
  local name_normalized = string.gsub(name, "/", "󰿟")
  local branch = vim.fn.system "git branch --show-current"

  if vim.v.shell_error == 0 then
    local branch_normalized = string.gsub(branch, "/", "󰿟")
    return name_normalized .. " @ " .. vim.trim(branch_normalized)
  else
    return name_normalized
  end
end

return M
