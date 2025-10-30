-- Only use vimade to fade the entire editor when the window is blurred
return {
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
