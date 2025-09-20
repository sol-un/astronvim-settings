-- Additional textobject borrowed from LazyVim, see:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/coding.lua#L34
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/mini.lua#L23

return {
  "echasnovski/mini.ai",
  event = "VeryLazy",
  opts = function()
    local ai = require "mini.ai"
    return {
      n_lines = 500,
      custom_textobjects = {
        t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tag
        d = { "%f[%d]%d+" }, -- digit(s)
        e = { -- CamelCase / snake_case
          { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
          "^().*()$",
        },
        g = function() -- entire file
          local start_line, end_line = 1, vim.fn.line "$"
          local last_char_col = math.max(vim.fn.getline(end_line):len(), 1)
          return { from = { line = start_line, col = 1 }, to = { line = end_line, col = last_char_col } }
        end,
        u = ai.gen_spec.function_call(), -- use/call
        U = ai.gen_spec.function_call { name_pattern = "[%w_]" }, -- use/call without dot in function name
      },
    }
  end,
  config = function(_, opts)
    require("mini.ai").setup(opts)
    require("astrocore").on_load("which-key.nvim", function()
      local objects = {
        { "t", desc = "tag" },
        { "d", desc = "digit(s)" },
        { "e", desc = "CamelCase / snake_case" },
        { "g", desc = "entire file" },
        { "u", desc = "use/call" },
        { "U", desc = "use/call without dot" },
      }

      ---@type wk.Spec[]
      local ret = { mode = { "o", "x" } }
      ---@type table<string, string>
      local mappings = vim.tbl_extend("force", {}, {
        around = "a",
        inside = "i",
      }, opts.mappings or {})

      for name, prefix in pairs(mappings) do
        ret[#ret + 1] = { prefix, group = name }
        for _, obj in ipairs(objects) do
          ret[#ret + 1] = { prefix .. obj[1], desc = name .. " " .. obj.desc }
        end
      end
      require("which-key").add(ret, { notify = false })
    end)
  end,
}
