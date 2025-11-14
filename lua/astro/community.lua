-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- UI
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.recipes.cache-colorscheme" },
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.scrolling.mini-animate" },
  { import = "astrocommunity.recipes.diagnostic-virtual-lines-current-line" },
  { import = "astrocommunity.editing-support.nvim-treesitter-context" },
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },

  -- Motion
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.mini-surround" },
  { import = "astrocommunity.motion.mini-ai" },
  { import = "astrocommunity.motion.marks-nvim" },

  -- Utils
  { import = "astrocommunity.editing-support.auto-save-nvim" },
  { import = "astrocommunity.file-explorer.mini-files" },
  { import = "astrocommunity.test.neotest" },
  { import = "astrocommunity.editing-support.vim-move" },
  { import = "astrocommunity.code-runner.overseer-nvim" },
  { import = "astrocommunity.completion.blink-cmp-emoji" },
  { import = "astrocommunity.search.grug-far-nvim" },

  -- Languages
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.eslint" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.prettier" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.cs" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.json" },
}
