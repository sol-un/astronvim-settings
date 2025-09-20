--- @type nil | vim.SystemObj[kill]
KILL = nil
IS_FOCUSED = true

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
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
  },
}
