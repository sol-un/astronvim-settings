local keymaps_meta = {
  { desc = "Bold", key = "b", symbol = "**" },
  { desc = "Italic", key = "i", symbol = "_" },
  { desc = "Code", key = "c", symbol = "`" },
  { desc = "Strikethrough", key = "s", symbol = "~~" },
}

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "codecompanion" },
    keys = function()
      local rmd = require "render-markdown"
      local set = require("snacks").keymap.set

      set({ "n", "v" }, "<Leader>m", "", { desc = "󰽛 Markdown", ft = "markdown" })

      set("n", "<Leader>mt", function()
        local was_enabled = rmd.get()
        rmd.set(not was_enabled)

        local next_state = was_enabled and "disabled" or "enabled"
        vim.notify("Render markdown " .. next_state)
      end, { ft = "markdown", desc = "Toggle preview" })

      vim.iter(keymaps_meta):each(function(keymap_meta)
        local key = keymap_meta.key
        local sym = keymap_meta.symbol
        local desc = keymap_meta.desc

        set("v", "<Leader>m" .. key, string.format('c%s<c-r>"%s<esc>', sym, sym), { ft = "markdown", desc = desc })
        set("n", "<Leader>m" .. key, string.format('viwc%s<c-r>"%s<esc>', sym, sym), { ft = "markdown", desc = desc })
      end)
    end,
  },
  {
    "antonk52/markdowny.nvim",
    event = "VeryLazy",
    keys = function()
      require("snacks").keymap.set(
        "v",
        "<Leader>ml",
        ":lua require('markdowny').link()<cr>",
        { ft = "markdown", desc = "Link" }
      )
    end,
  },
}
