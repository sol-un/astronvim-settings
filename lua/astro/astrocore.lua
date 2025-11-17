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
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
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
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = true, -- sets vim.opt.wrap
        linebreak = true,
        spelllang = { "en", "ru" },
      },
      o = {
        shell = vim.uv.os_uname().sysname == "Windows_NT" and "powershell" or vim.o.shell,
        sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,terminal",
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file

        -- Setting up clipboard on WSL
        clipboard = vim.fn.isdirectory "/mnt/c" == 1 and {
          name = "win32yank-wsl",
          copy = {
            ["+"] = "win32yank.exe -i --crlf",
            ["*"] = "win32yank.exe -i --crlf",
          },
          paste = {
            ["+"] = "win32yank.exe -o --lf",
            ["*"] = "win32yank.exe -o --lf",
          },
          cache_enabled = true,
        } or vim.g.clipboard,
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map
        -- navigate buffer tabs
        -- ["b]"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },
        -- mappings seen under group name "Buffer"

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
  },
}
