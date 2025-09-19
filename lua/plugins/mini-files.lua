return {
  "echasnovski/mini.files",
  event = "VeryLazy",
  opts = {
    windows = {
      preview = true,
      max_number = 2,
      width_focus = math.floor(vim.o.columns * 0.29),
      width_preview = math.floor(vim.o.columns * 0.69),
    },
  },
}
