return {
  {
    "TaDaa/vimade",
    event = "VeryLazy",
    enabled = false,
    opts = {
      recipe = { "default", { animate = true } },
      ncmode = "buffers",
      enablefocusfading = true,
      usecursorhold = true,
      blocklist = {
        -- As long as the editor is focused, never fade windows in a tab that has a DiffviewFiles type buffer, as defined by the sindrets/diffview.nvim plugin
        diffview_tab = function()
          if not require("plugins.autocmds").IS_FOCUSED then return false end

          for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.api.nvim_get_option_value("filetype", { buf = buf }) == "DiffviewFiles" then return true end
          end

          return false
        end,
      },
    },
  },
  -- {
  --   "AstroNvim/astrocore",
  --   ---@type AstroCoreOpts
  --   opts = {
  --     mappings = {
  --       n = {
  --         ["<Leader>uv"] = {
  --           "<cmd>VimadeToggle<cr>",
  --           desc = "Toggle vimade",
  --         },
  --       },
  --     },
  --   },
  -- },
  {
    "nvim-zh/colorful-winsep.nvim",
    event = "VeryLazy",
    opts = {
      border = "rounded",
      highlight = function()
        local hl = vim.api.nvim_get_hl(0, { name = "FloatBorder" })
        vim.api.nvim_set_hl(0, "ColorfulWinSep", { fg = hl.fg, bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg })
      end,
    },
  },
}
