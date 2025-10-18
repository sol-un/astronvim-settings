return {
  "rebelot/heirline.nvim",
  dependencies = {
    {
      "AstroNvim/astroui",

      opts = {
        icons = {
          Clock = "",
        },
      },
    },
  },
  opts = function(_, opts)
    local status = require "astroui.status"
    opts.statusline = {
      hl = { fg = "fg", bg = "bg" },
      status.component.mode {
        mode_text = { padding = { left = 1, right = 1 } },
      },
      status.component.git_branch(),
      {
        status.component.builder {
          { provider = require("astroui").get_icon "FolderClosed" },
        },
        status.component.file_info {
          filename = {
            fname = function(nr) return vim.fn.getcwd(nr) end,
            padding = { left = 1 },
          },
          filetype = false,
          file_icon = false,
          file_modified = false,
          file_read_only = false,
          surround = {
            separator = "none",
            color = "file_info_bg",
            condition = false,
          },
        },
      },
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp(),
      status.component.virtual_env(),
      status.component.nav { percentage = false, scrollbar = false, padding = { right = 1 } },
      status.component.builder {
        {
          provider = function()
            local time = os.date "%H:%M"

            ---@cast time string
            return status.utils.stylize(time, {
              icon = { kind = "Clock", padding = { left = 1, right = 1 } },
              padding = { right = 1 },
            })
          end,
        },
        update = {
          "User",
          callback = vim.schedule_wrap(function(_, args)
            if args.match == "UpdateTime" then vim.cmd.redrawstatus() end
          end),
        },
      },
    }

    vim.uv.new_timer():start(
      (60 - tonumber(os.date "%S")) * 1000,
      60000,
      vim.schedule_wrap(function() vim.api.nvim_exec_autocmds("User", { pattern = "UpdateTime", modeline = false }) end)
    )
  end,
}
