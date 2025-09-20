return {
  "s1n7ax/nvim-window-picker",
  opts = {
    hint = "floating-big-letter",
    selection_chars = "FJDKSLA;CMRUEIWOQP",
    picker_config = {
      statusline_winbar_picker = { use_winbar = "never" },
      handle_mouse_click = false,
      floating_big_letter = {
        font = "ansi-shadow",
      },
    },
    show_prompt = false,
    filter_rules = {
      autoselect_one = true,
      include_current_win = false,
      include_unfocusable_windows = false,
      bo = {
        filetype = { "NvimTree", "neo-tree", "notify", "snacks_notif" },
        buftype = { "terminal" },
      },
    },
  },
}
