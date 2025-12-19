local M = {}

M.CURRENT = nil

local sort_by_modified_time = function(sessions)
  local session_metas = vim
    .iter(vim.tbl_values(sessions))
    :filter(function(session) return session.name ~= M.CURRENT end)
    :totable()

  table.sort(session_metas, function(a, b) return a.modify_time > b.modify_time end)

  return vim.iter(session_metas):map(function(session) return session.name end):totable()
end

---@param action "read"|"delete"
M.read_or_delete = function(action)
  local ms = require "mini.sessions"
  local sorted_session_names = sort_by_modified_time(ms.detected)
  local current_session_name = M.CURRENT ~= nil and " (" .. M.CURRENT .. ")" or ""

  vim.ui.select(sorted_session_names, {
    prompt = "Select session to " .. action .. current_session_name,
  }, function(session)
    if session then ms[action](session) end
  end)
end

M.get_session_name = function()
  local name = vim.fn.getcwd()
  local name_normalized = string.gsub(name, "/", "󰿟")
  return name_normalized
end

return M
