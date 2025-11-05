return {
  { "nsidorenco/neotest-vstest" },
  {
    "nvim-neotest/neotest",
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end

      for i, adapter in ipairs(opts.adapters) do
        if adapter["name"] == "neotest-dotnet" then table.remove(opts.adapters, i) end
      end

      table.insert(opts.adapters, require "neotest-vstest"())
    end,
  },
}
