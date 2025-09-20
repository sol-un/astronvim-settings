return {
  "rebelot/heirline.nvim",
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
      status.component.treesitter(),
      status.component.nav(),
    }
  end,
}
