-- function for calculating the current session name
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

return {
  -- replace w/ mini.sessions
  { "resession.nvim", enabled = false },
  { "nvim-mini/mini.sessions", opts = {} },
  { "notjedi/nvim-rooter.lua", lazy = false, opts = {} },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      rooter = {
        -- replace w/ nvim-rooter
        enabled = false,
      },
      sessions = {
        -- disable the auto-saving of directory sessions
        autosave = { cwd = false },
      },
      mappings = {
        n = {
          ["<Leader>Sl"] = {
            function()
              local last_session = require("mini.sessions").get_latest()
              require("mini.sessions").read(last_session)
            end,
            desc = "Last session",
          },
          ["<Leader>SD"] = {
            function() require("mini.sessions").select "delete" end,
            desc = "Delete session",
          },
          ["<Leader>SF"] = {
            function() require("mini.sessions").select() end,
            desc = "Select session",
          },
          -- update save dirsession mapping to get the correct session name
          ["<Leader>SS"] = {
            function() require("mini.sessions").write(get_session_name()) end,
            desc = "Save this session",
          },
        },
      },
      autocmds = {
        git_branch_sessions = {
          -- auto save directory sessions on leaving
          {
            event = "VimLeavePre",
            desc = "Save git branch directory sessions on close",
            callback = vim.schedule_wrap(function()
              if require("astrocore.buffer").is_valid_session() then
                require("mini.sessions").write(get_session_name())
              else
                vim.notify("Error saving session", vim.log.levels.ERROR)
              end
            end),
          },
          -- {
          --   event = "User",
          --   pattern = { "NeogitBranchCheckout" },
          --   desc = "Switch session on neogit branch checkout",
          --   callback = function(args)
          --     local sessions = require("resession").list { dir = "dirsession" }
          --     local branch_name_serialized = string.gsub(args.data.branch_name, "/", "_")
          --
          --     for _, session_name in ipairs(sessions) do
          --       if string.match(session_name, branch_name_serialized) ~= nil then
          --         require("resession").load(session_name, { dir = "dirsession", notify = true })
          --       end
          --     end
          --   end,
          -- },
        },
      },
    },
  },
}
