local get_session_name = function()
  local name = vim.fn.getcwd()
  local name_normalized = string.gsub(name, "/", "󰿟")
  local branch = vim.fn.system "git branch --show-current"

  if vim.v.shell_error == 0 then
    local branch_normalized = string.gsub(branch, "/", "󰿟")
    return name_normalized .. " @ " .. vim.trim(branch_normalized --[[@as string]])
  else
    return name_normalized
  end
end

local CURRENT = nil

local highlight_current = function(session)
  if session ~= CURRENT then return session end

  return " " .. session
end

---@param action "read"|"delete"
local read_or_delete = function(action)
  vim.ui.select(vim.tbl_keys(MiniSessions.detected), {
    prompt = action:gsub("^%l", string.upper) .. " session",
    format_item = highlight_current,
  }, function(session)
    if session then MiniSessions[action](session) end
  end)
end

return {
  { "stevearc/resession.nvim", enabled = false },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      rooter = {
        enabled = false,
      },
    },
  },
  { "notjedi/nvim-rooter.lua", lazy = false, opts = {} },
  {
    "nvim-mini/mini.sessions",
    lazy = false,
    opts = {
      hooks = {
        post = {
          read = function(current)
            CURRENT = current["name"]
            vim.cmd ":Rooter"
          end,
        },
      },
    },
    keys = {
      { "<Leader>S" },
      {
        "<Leader>Sl",
        function()
          local last_session = require("mini.sessions").get_latest()
          require("mini.sessions").read(last_session)
        end,
        desc = "Last session",
      },
      {
        "<Leader>SD",
        function() read_or_delete "delete" end,
        desc = "Delete session",
      },
      {
        "<Leader>SF",
        function() read_or_delete "read" end,
        desc = "Select session",
      },
      {
        "<Leader>SS",
        function() require("mini.sessions").write(get_session_name()) end,
        desc = "Save this session",
      },
    },
  },
}
