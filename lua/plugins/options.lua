---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      o = {
        shell = vim.uv.os_uname().sysname == "Windows_NT" and "powershell" or vim.o.shell,
      },
      opt = {
        spelllang = { "en", "ru" },
      },
      g = {
        clipboard = vim.fn.has "wsl" and {
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
  },
}
