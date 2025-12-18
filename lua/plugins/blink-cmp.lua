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
      -- "path" source in opencode input window interferes with slash commands. Dropping it and snippets
      per_filetype = { opencode = { "buffer", "lsp" } },
    },
  },
}
