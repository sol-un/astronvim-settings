-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

KILL = nil
IS_FOCUSED = true

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
    autocmds = {
      neogit = {
        {
          desc = "Update buffers on Neogit events",
          event = "User",
          pattern = { "NeogitBranchCheckout", "NeogitPullComplete" },
          callback = function() vim.cmd "set autoread | checktime" end,
        },
        {
          desc = "Rebuild postavki backend on branch checkout",
          event = "User",
          pattern = { "NeogitBranchCheckout" },
          callback = function()
            if string.find(vim.fn.getcwd(), "postavki") == nil then return end

            if KILL ~= nil then KILL() end

            vim.notify "Start rebuilding postavki backend"

            local process = vim.system({ "rebuildAll.cmd" }, nil, function(result)
              KILL = nil

              if result.code ~= 0 then
                vim.notify("Error rebuilding postavki backend\n\n" .. result.stderr, vim.log.levels.ERROR)
                return
              end

              vim.notify "Done rebuilding postavki backend"
            end)

            KILL = process.kill
          end,
        },
      },
      focus = {
        {
          desc = "Store focused state",
          event = "FocusGained",
          callback = function() IS_FOCUSED = true end,
        },
        {
          desc = "Store blurred state",
          event = "FocusLost",
          callback = function() IS_FOCUSED = false end,
        },
      },
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
        spelllang = { "en", "ru" },
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file

        clipboard = function()
          if vim.fn.has "wsl" then
            return {
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
            }
          end
        end,
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
