return {
  {
    "sudo-tee/opencode.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MeanderingProgrammer/render-markdown.nvim",
      "saghen/blink.cmp",
      "folke/snacks.nvim",
    },
    opts = {
      default_mode = "plan",
      preferred_completion = "vim_complete",
      default_global_keymaps = false,
      ui = { input = { text = { wrap = true } } },
      context = {
        enabled = false,
        cursor_data = {
          enabled = false,
        },
        diagnostics = {
          info = false,
          warn = false,
          error = false,
        },
        current_file = {
          enabled = false,
        },
        selection = {
          enabled = false,
        },
      },
      keymap = {
        input_window = {
          ["<C-s>"] = { "submit_input_prompt", mode = { "n", "i" } },
          ["<C-c>"] = { "cancel" },
          ["@"] = { "mention_file", mode = "i" },
          ["~"] = { "mention", mode = "i" },
        },
        session_picker = {
          rename_session = { "<M-r>" },
          delete_session = { "<M-d>" },
          new_session = { "<M-n>" },
        },
        timeline_picker = {
          undo = { "<M-u>", mode = { "i", "n" } },
          fork = { "<M-f>", mode = { "i", "n" } },
        },
        history_picker = {
          delete_entry = { "<M-d>", mode = { "i", "n" } },
          clear_all = { "<M-x>", mode = { "i", "n" } },
        },
      },
    },
    keys = function()
      local set = require("snacks").keymap.set
      local opencode = require "opencode.api"
      set("n", "<Leader>ac", function() opencode.open_input_new_session() end, { desc = "New session" })
      set("n", "<Leader>ah", function() opencode.select_session() end, { desc = "Select session" })
      set(
        "n",
        "<Leader>at",
        function() opencode.timeline() end,
        { desc = "Timeline picker", ft = { "opencode", "opencode_output" } }
      )
    end,
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>a"] = { desc = " AI" },
          ["<Leader>aD"] = false,
        },
      },
    },
  },
}
