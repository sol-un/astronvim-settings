return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "codecompanion" },
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>um"] = {
            function()
              local was_enabled = require("render-markdown").get()
              require("render-markdown").set(not was_enabled)
              local next_state = was_enabled and "disabled" or "enabled"
              vim.notify("Render markdown " .. next_state)
            end,
            desc = "Toggle markdown preview",
          },
        },
      },
    },
  },
}
