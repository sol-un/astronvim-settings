local utils = require "session-utils"

return {
  { "stevearc/resession.nvim", enabled = false },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      rooter = {
        enabled = false,
      },
      mappings = {
        n = {
          ["<Leader>S"] = { desc = " Session" },
        },
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
            utils.CURRENT = current["name"]
            vim.cmd ":Rooter"
          end,
        },
      },
    },
    keys = {
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
        function() utils.read_or_delete "delete" end,
        desc = "Delete session",
      },
      {
        "<Leader>SF",
        function() utils.read_or_delete "read" end,
        desc = "Select session",
      },
      {
        "<Leader>SS",
        function() require("mini.sessions").write(utils.get_session_name()) end,
        desc = "Save this session",
      },
    },
  },
}
