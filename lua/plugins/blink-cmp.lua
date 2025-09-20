return {
  "Saghen/blink.cmp",
  event = { "CmdlineEnter" },
  opts = {
    cmdline = {
      enabled = true,
      keymap = {
        preset = "cmdline",
      },
      completion = {
        list = { selection = { preselect = false } },
        menu = {
          auto_show = function() return vim.fn.getcmdtype() == ":" end,
        },
        ghost_text = { enabled = true },
      },
    },
    sources = {
      -- Autocomplete from visible buffers in codecompanion chat
      per_filetype = { codecompanion = { inherit_defaults = true } },
    },
  },
}
