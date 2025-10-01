return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      n = {
        ["<Leader>xL"] = false,
        ["<Leader>xQ"] = false,
        ["<Leader>xl"] = { "<Cmd>Trouble loclist toggle<CR>", desc = "Trouble Location List" },
        ["<Leader>xq"] = { "<Cmd>Trouble quickfix toggle<CR>", desc = "Trouble Quickfix List" },
      },
    },
  },
}
