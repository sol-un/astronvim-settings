-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      -- extension = {
      --   foo = "fooscript",
      -- },
      -- filename = {
      --   [".foorc"] = "fooscript",
      -- },
      -- pattern = {
      --   [".*/etc/foo/.*"] = "fooscript",
      -- },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map
        -- navigate buffer tabs
        ["L"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["H"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },
        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
        ["<Leader>tt"] = {
          function() vim.notify(vim.inspect(require("astrocore.rooter").detect(0, false))) end,
          -- function() require("snacks").terminal(nil, { cwd = require("astrocore.rooter").info() }) end,
          desc = "Toggle terminal",
        },

        -- move lines
        ["<A-k>"] = { ":m .-2<CR>==", desc = "Move up" },
        ["<A-j>"] = { ":m .+1<CR>==", desc = "Move down" },

        -- tabs
        ["<Leader><Tab>"] = { desc = "Tabs" },
        ["<Leader><Tab>o"] = { "<cmd>tabonly<cr>", desc = "Close Other Tabs" },
        ["<Leader><Tab><Tab>"] = { "<cmd>tabnew<cr>", desc = "New Tab" },
        ["<Leader><Tab>d"] = { "<cmd>tabclose<cr>", desc = "Close Tab" },
        ["gt"] = { "<cmd>tabnext<cr>", desc = "Next Tab" },
        ["gT"] = { "<cmd>tabprevious<cr>", desc = "Previous Tab" },

        -- resize window using <ctrl> arrow keys
        ["<C-Up>"] = { "<cmd>resize +2<cr>", desc = "Increase Window Height" },
        ["<C-Down>"] = { "<cmd>resize -2<cr>", desc = "Decrease Window Height" },
        ["<C-Left>"] = { "<cmd>vertical resize -2<cr>", desc = "Decrease Window Width" },
        ["<C-Right>"] = { "<cmd>vertical resize +2<cr>", desc = "Increase Window Width" },

        --splits
        ["<Leader>b\\"] = false,
        ["<Leader>bh"] = { "<cmd>split<cr>",  desc = "Horizontal split" },
        ["<Leader>bH"] = {
          function()
            require("astroui.status.heirline").buffer_picker(function(bufnr)
              vim.cmd.split()
              vim.api.nvim_win_set_buf(0, bufnr)
            end)
          end,
          desc = "Horizontal split buffer from tabline",
        },
        ["<Leader>b|"] = false,
        ["<Leader>bv"] = { "<cmd>vsplit<cr>", desc = "Vertical split" },
        ["<Leader>bV"] = {
          function()
            require("astroui.status.heirline").buffer_picker(function(bufnr)
              vim.cmd.vsplit()
              vim.api.nvim_win_set_buf(0, bufnr)
            end)
          end,
          desc = "Vertical split buffer from tabline",
        },
      },
      i = {
        -- save
        ["<C-s>"] = {
          "<Cmd>:w<CR><Esc>",
        },

        -- move lines
        ["<A-k>"] = { "<esc>:m .-2<CR>==gi", desc = "Move up" },
        ["<A-j>"] = { "<esc>:m .+1<CR>==gi", desc = "Move down" },
      },
      v = {
        -- move lines
        ["<A-j>"] = { ":m '>+1<CR>gv=gv", desc = "Move up" },
        ["<A-k>"] = { ":m '<-2<CR>gv=gv", desc = "Move down" },

        -- better indenting
        ["<"] = { "<gv" },
        [">"] = { ">gv" },
      },
    },
  },
}
