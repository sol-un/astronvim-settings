-- Autocomplete from visible buffers in codecompanion chat

return {
  "Saghen/blink.cmp",
  opts = {
    sources = {
      per_filetype = { codecompanion = { inherit_defaults = true } },
    },
  },
}
