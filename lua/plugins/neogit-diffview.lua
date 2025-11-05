return {
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    cmd = "Neogit",
    branch = "master",
    opts = {
      kind = "split",
      graph_style = "unicode",
      integrations = {
        diffview = true,
        snacks = true,
      },
      signs = {
        item = { " ", " " },
        section = { " ", " " },
      },
      mappings = {
        commit_editor = {
          ["<c-s>"] = "Submit",
          ["<c-k>"] = "Abort",
        },
        commit_editor_I = {
          ["<c-s>"] = "Submit",
          ["<c-k>"] = "Abort",
        },
        rebase_editor = {
          ["<c-s>"] = "Submit",
          ["<c-k>"] = "Abort",
        },
        rebase_editor_I = {
          ["<c-s>"] = "Submit",
          ["<c-k>"] = "Abort",
        },
      },
      status = { recent_commit_count = 30 },
      sections = { recent = { folded = false } },
      commit_editor = {
        kind = "vsplit",
      },
      commit_select_view = {
        kind = "vsplit",
      },
      log_view = {
        kind = "vsplit",
      },
      reflog_view = {
        kind = "vsplit",
      },
      stash = {
        kind = "vsplit",
      },
      refs_view = {
        kind = "vsplit",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    opts = {
      enhanced_diff_hl = true,
      file_panel = {
        win_config = {
          position = "bottom",
          height = math.floor(vim.o.lines * 0.3),
        },
      },
    },
  },
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>gd"] = false,
          ["<Leader>gg"] = { "<cmd>Neogit<cr>", desc = "Neogit" },
        },
      },
      autocmds = {
        neogit = {
          {
            desc = "Update buffers on Neogit events",
            event = "User",
            pattern = { "NeogitBranchCheckout", "NeogitPullComplete" },
            callback = function() vim.cmd "set autoread | checktime" end,
          },
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    opts = { mappings = { n = {
      ["<Leader>gd"] = { "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
    } } },
  },
}
