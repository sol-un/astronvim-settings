-- These are better off using Snacks.picker
for _, lhs in ipairs { "gra", "grt", "n", "grn", "grr", "gri", "gO" } do
  pcall(vim.keymap.del, { "n", "x" }, lhs)
end

---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          -- Remapped below to the "Windows" menu item
          ["<Leader>w"] = false,
        },
      },
    },
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>Q"] = false,
          ["<Leader>qq"] = { "<Cmd>confirm qall<CR>", desc = "Exit AstroNvim" },

          -- move lines
          ["<A-k>"] = { "<cmd>m .-2<CR>==", desc = "Move up" },
          ["<A-j>"] = { "<cmd>m .+1<CR>==", desc = "Move down" },

          -- tabs
          ["<Leader><Tab>"] = { desc = "Tabs" },
          ["<Leader><Tab>o"] = { "<cmd>tabonly<cr>", desc = "Close Other Tabs" },
          ["<Leader><Tab><Tab>"] = { "<cmd>tabnew<cr>", desc = "New Tab" },
          ["<Leader><Tab>d"] = { "<cmd>tabclose<cr>", desc = "Close Tab" },
          ["gt"] = { "<cmd>tabnext<cr>", desc = "Next Tab" },
          ["gT"] = { "<cmd>tabprevious<cr>", desc = "Previous Tab" },

          -- windows
          ["<Leader>u"] = { desc = "󱋆 UI/UX" },
          ["<Leader>w"] = { desc = " Windows" },
          ["<Leader>q"] = false,
          ["<Leader>wv"] = { "<cmd>vsplit<cr>", desc = "Vertical split" },
          ["<Leader>wd"] = { "<C-W>c", desc = "Close current window" },
          ["<Leader>wh"] = { "<cmd>split<cr>", desc = "Horizontal split" },
          ["<Leader>wo"] = { "<cmd>only<cr>}", desc = "Close all other windows" },
          ["<Leader>wJ"] = { "<C-W>J", desc = "Move window to far bottom" },
          ["<Leader>wK"] = { "<C-W>K", desc = "Move window to far top" },
          ["<Leader>wH"] = { "<C-W>H", desc = "Move window to far left" },
          ["<Leader>wL"] = { "<C-W>L", desc = "Move window to far right" },
          ["<C-Up>"] = { require("smart-splits").resize_up, desc = "Increase Window Height" },
          ["<C-Down>"] = { require("smart-splits").resize_down, desc = "Decrease Window Height" },
          ["<C-Left>"] = { require("smart-splits").resize_left, desc = "Decrease Window Width" },
          ["<C-Right>"] = { require("smart-splits").resize_right, desc = "Increase Window Width" },
          ["<Leader>ww"] = {
            function()
              local id = require("window-picker").pick_window()
              if type(id) == "number" then vim.fn.win_gotoid(id) end
            end,
            desc = "Select window",
          },
          -- buffers
          ["L"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
          ["H"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
          ["<Leader>c"] = false,
          ["<Leader>C"] = false,
          ["<Leader>bd"] = {
            function() require("astrocore.buffer").close(0) end,
            desc = "Close current buffer",
          },
          ["<Leader>bD"] = {
            function()
              require("astroui.status.heirline").buffer_picker(
                function(bufnr) require("astrocore.buffer").close(bufnr) end
              )
            end,
            desc = "Close buffer from tabline",
          },
          ["<Leader>bc"] = false,
          ["<Leader>bo"] = {
            function() require("astrocore.buffer").close_all(true) end,
            desc = "Close all other buffers",
          },
          ["<Leader>bC"] = false,
          ["<Leader>bA"] = { function() require("astrocore.buffer").close_all() end, desc = "Close all buffers" },
          ["<Leader>b\\"] = false,
          ["<Leader>bh"] = {
            function()
              require("astroui.status.heirline").buffer_picker(function(bufnr)
                vim.cmd.split()
                vim.api.nvim_win_set_buf(0, bufnr)
              end)
            end,
            desc = "Horizontal split buffer from tabline",
          },
          ["<Leader>b|"] = false,
          ["<Leader>bv"] = {
            function()
              require("astroui.status.heirline").buffer_picker(function(bufnr)
                vim.cmd.vsplit()
                vim.api.nvim_win_set_buf(0, bufnr)
              end)
            end,
            desc = "Vertical split buffer from tabline",
          },
          ["<leader>,"] = { function() Snacks.picker.buffers() end, desc = "Buffers" },

          -- terminal
          -- this is the same as Ctrl + /, see https://apple.stackexchange.com/questions/24261/how-do-i-send-c-that-is-control-slash-to-the-terminal
          ["<C-_>"] = {
            function() require("snacks").terminal(nil, { cwd = vim.uv.cwd() }) end,
            desc = "Toggle terminal",
          },
          ["<C-/>"] = {
            function() require("snacks").terminal(nil, { cwd = vim.uv.cwd() }) end,
            desc = "Toggle terminal",
          },

          -- git
          ["<Leader>gT"] = false,
          ["<Leader>go"] = false,
          ["<Leader>gt"] = false,
          ["<Leader>gc"] = false,
          ["<Leader>gC"] = false,
          ["<Leader>gb"] = { function() require("gitsigns").blame_line() end, desc = "Git blame line" },
          ["<Leader>gB"] = { function() require("gitsigns").blame_line { full = true } end, desc = "Git blame file" },
          ["<Leader>gz"] = { function() require("snacks").picker.git_stash() end, desc = "Git stash" },
          ["<Leader>gf"] = {
            "<cmd>DiffviewFileHistory %<cr>",
            desc = "Git commit history (file)",
          },
          ["<Leader>gF"] = {
            "<cmd>DiffviewFileHistory<cr>",
            desc = "Git commit history (repository)",
          },
        },
        i = {
          -- save
          ["<C-s>"] = {
            "<Cmd>w<CR><Esc>",
          },

          -- move lines
          ["<A-k>"] = { "<esc><cmd>m .-2<CR>==gi", desc = "Move up" },
          ["<A-j>"] = { "<esc><cmd>m .+1<CR>==gi", desc = "Move down" },
        },
        v = {
          -- move lines
          ["<A-j>"] = { "<cmd>m '>+1<CR>gv=gv", desc = "Move up" },
          ["<A-k>"] = { "<cmd>m '<-2<CR>gv=gv", desc = "Move down" },

          -- better indenting
          ["<"] = { "<gv" },
          [">"] = { ">gv" },
        },
        t = {
          ["<C-/>"] = { "<cmd>close<cr>", desc = "Hide Terminal" },
          ["<C-_>"] = { "<cmd>close<cr>", desc = "Hide Terminal" },
          ["<C-h>"] = { "<Backspace>" },
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          ["gd"] = {
            function() require("snacks").picker.lsp_definitions() end,
            desc = "Goto Definition",
          },
          ["gr"] = { function() require("snacks").picker.lsp_references() end, desc = "References" },
          ["gI"] = { function() require("snacks").picker.lsp_implementations() end, desc = "Goto Implementation" },
          ["gy"] = {
            function() require("snacks").picker.lsp_type_definitions() end,
            desc = "Goto T[y]pe Definition",
          },
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { mode = "n" },
        { "<Leader>gl", function() end, hidden = true },
        { "<Leader>gL", function() end, hidden = true },
      },
    },
  },
}
