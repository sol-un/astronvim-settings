-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- UI
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.scrolling.mini-animate" },

  -- Motion
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.mini-surround" },
  { import = "astrocommunity.motion.mini-ai" },

  -- Utils
  { import = "astrocommunity.editing-support.auto-save-nvim" },
  { import = "astrocommunity.file-explorer.mini-files" },
  { import = "astrocommunity.test.neotest" },

  -- Languages
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.eslint" },
  { import = "astrocommunity.pack.prettier" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.cs" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.json" },
}
