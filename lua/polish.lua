-- -- This will run last in the setup process.
-- -- This is just pure lua so anything that doesn't
-- -- fit in the normal config locations above can go here

-- vim.api.nvim_create_autocmd("User", {
--   pattern = { "NeogitBranchCheckout", "NeogitPullComplete" },
--   callback = function() vim.cmd "set autoread | checktime" end,
-- })
--
-- KILL = nil
--
-- -- rebuild postavki backend on Neogit branch checkout
-- vim.api.nvim_create_autocmd("User", {
--   pattern = { "NeogitBranchCheckout" },
--   callback = function()
--     if string.find(vim.fn.getcwd(), "postavki") == nil then return end
--
--     if KILL ~= nil then KILL() end
--
--     vim.notify "Start rebuilding postavki backend"
--
--     local process = vim.system({ "rebuildAll.cmd" }, nil, function(result)
--       KILL = nil
--
--       if result.code ~= 0 then
--         vim.notify("Error rebuilding postavki backend\n\n" .. result.stderr, vim.log.levels.ERROR)
--         return
--       end
--
--       vim.notify "Done rebuilding postavki backend"
--     end)
--
--     KILL = process.kill
--   end,
-- })

vim.opt.spelllang = { "en", "ru" }

if vim.uv.os_uname().sysname == "Windows_NT" then vim.o.shell = "powershell" end

vim.filetype.add {
  pattern = {
    ["%.gitlab%-ci%.ya?ml"] = "yaml.gitlab",
  },
}

-- Makes clipboard work with Windows when running in WSL. See also https://github.com/victor-dev-00/clip-nvim
if vim.fn.has "wsl" then
  vim.g.clipboard = {
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
