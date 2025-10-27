return {
  {
    "nvim-zh/colorful-winsep.nvim",
    event = "VeryLazy",
    opts = {
      border = "rounded",
      excluded_ft = { "NeogitPopup" },
      highlight = function()
        local hl = vim.api.nvim_get_hl(0, { name = "FloatBorder" })
        vim.api.nvim_set_hl(0, "ColorfulWinSep", { fg = hl.fg })
      end,
      indicator_for_2wins = {
        symbols = {
          start_left = "󰄾",
          end_left = "󰄾",
          start_down = "󰄿",
          end_down = "󰄿",
          start_up = "󰄼",
          end_up = "󰄼",
          start_right = "󰄽",
          end_right = "󰄽",
        },
      },
    },
  },
  -- Only use vimade to fade the entire editor when the window is blurred
  {
    "TaDaa/vimade",
    event = "VeryLazy",
    opts = {
      recipe = { "default", { animate = true } },
      enablefocusfading = true,
    },
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      autocmds = {
        focus = {
          {
            event = "FocusGained",
            callback = function() vim.cmd "VimadeDisable" end,
          },
          {
            event = "FocusLost",
            callback = function() vim.cmd "VimadeEnable" end,
          },
        },
      },
    },
  },
}
