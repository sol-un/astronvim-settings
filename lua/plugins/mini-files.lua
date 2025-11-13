return {
  {
    "nvim-mini/mini.files",
    event = "VeryLazy",
    opts = {
      windows = {
        preview = true,
        max_number = 2,
        width_focus = math.floor(vim.o.columns * 0.29),
        width_preview = math.floor(vim.o.columns * 0.69),
      },
    },
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>e"] = {
            function()
              if not require("mini.files").close() then require("mini.files").open(vim.api.nvim_buf_get_name(0)) end
            end,
            desc = "Explorer",
          },
          ["<Leader>E"] = {
            function()
              if not require("mini.files").close() then require("mini.files").open(vim.uv.cwd()) end
            end,
            desc = "Explorer (CWD)",
          },
        },
      },
    },
  },
}
