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
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      -- AstroNvim uses gitsigns' on_attach setting to set up keymaps
      -- Set it to nil and assign keymaps below via astrocore settings
      opts.on_attach = nil
      return opts
    end,
  },
  {
    "linrongbin16/gitlinker.nvim",
    event = "VeryLazy",
    opts = {
      router = {
        current_branch = {
          ["^git%.skbkontur%.ru"] = "https://git.skbkontur.ru/"
            .. "{_A.ORG}/"
            .. "{_A.REPO}/blob/"
            .. "{_A.CURRENT_BRANCH}/"
            .. "{_A.FILE}"
            .. "#L{_A.LSTART}"
            .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
        },
      },
    },
  },
  {
    "harrisoncramer/gitlab.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    build = function() require("gitlab.server").build(true) end,
    opts = {
      reviewer_settings = {
        jump_with_no_diagnostics = true,
        diffview = {
          imply_local = true,
        },
      },
      keymaps = {
        discussion_tree = {
          toggle_sort_method = "gSt",
          toggle_date_format = "gDt",
          add_emoji = "gEa",
          delete_emoji = "gEd",
        },
        popup = {
          perform_action = "<C-s>",
          discard_changes = "<C-k>",
        },
      },
      discussion_tree = {
        position = "left",
        keep_current_open = true,
        draft_mode = true,
        tree_type = "by_file_name",
      },
    },
  },
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          -- neogit
          ["<Leader>gg"] = { "<cmd>Neogit<cr>", desc = "Neogit" },

          -- diffview
          ["<Leader>gd"] = { "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
          ["<Leader>gf"] = {
            "<cmd>DiffviewFileHistory %<cr>",
            desc = "Git commit history (file)",
          },
          ["<Leader>gF"] = {
            "<cmd>DiffviewFileHistory<cr>",
            desc = "Git commit history (repository)",
          },

          -- gitsigns
          ["<Leader>gp"] = { function() require("gitsigns").preview_hunk_inline() end, desc = "Preview Git" },
          ["<Leader>gr"] = { function() require("gitsigns").reset_hunk() end, desc = "Reset Git hunk" },
          ["<Leader>gR"] = { function() require("gitsigns").reset_buffer() end, desc = "Reset Git buffer" },
          ["<Leader>gs"] = { function() require("gitsigns").stage_hunk() end, desc = "Stage/Unstage Git hunk" },
          ["<Leader>gS"] = { function() require("gitsigns").stage_buffer() end, desc = "Stage Git buffer" },
          ["<Leader>gb"] = { function() require("gitsigns").blame_line() end, desc = "Git blame line" },
          ["<Leader>gB"] = { function() require("gitsigns").blame_line { full = true } end, desc = "Git blame file" },
          ["]h"] = { function() require("gitsigns").nav_hunk "next" end, desc = "Next Git hunk" },
          ["[h"] = { function() require("gitsigns").nav_hunk "prev" end, desc = "Previous Git hunk" },

          -- gitlinker
          ["<Leader>gy"] = { "<cmd>GitLink current_branch<cr>", desc = "Yank git link" },
          ["<Leader>gY"] = { "<cmd>GitLink! current_branch<cr>", desc = "Open git link" },

          ["gl"] = { desc = "GitLab..." },

          -- disable git-related snacks picker keymaps, this is covered by neogit
          ["<Leader>gT"] = false, -- git stash
          ["<Leader>go"] = false, -- browse repository
          ["<Leader>gt"] = false, -- git status
          ["<Leader>gc"] = false, -- git commits (repository)
          ["<Leader>gC"] = false, -- git commits (current file)

          -- opens all files listed in a neogit commit view
          -- this is to open all files modified in a certain commit
          -- not sure if I need this rn, commenting out
          -- ["<Leader>gm"] = {
          --   function()
          --     local paths_to_open = ""
          --     local commit_hash_to_open = ""
          --
          --     if vim.bo.filetype == "NeogitCommitView" then
          --       local first_line = unpack(vim.api.nvim_buf_get_lines(0, 0, 1, true))
          --       local _, commit_hash = unpack(vim.split(first_line, " "))
          --
          --       commit_hash_to_open = commit_hash
          --       paths_to_open =
          --         vim.fn.system(string.format("git diff-tree --no-commit-id --name-only %s -r", commit_hash))
          --     else
          --       paths_to_open = vim.fn.system "git diff --name-only"
          --     end
          --
          --     if paths_to_open == "" then
          --       vim.notify "No modified files"
          --     else
          --       local message = commit_hash_to_open == "" and "Opened currently modified files"
          --         or string.format("Opened files modified in commit %s", commit_hash_to_open)
          --       vim.cmd(string.format(":args %s", paths_to_open:gsub("[\n\r]", " ")))
          --       vim.notify(message)
          --     end
          --   end,
          --   desc = "Open modified files",
          -- },
        },
        v = {
          -- gitsigns
          ["<Leader>gs"] = {
            function() require("gitsigns").stage_hunk { vim.fn.line ".", vim.fn.line "v" } end,
            desc = "Stage Git hunk",
          },
          ["<Leader>gr"] = {
            function() require("gitsigns").reset_hunk { vim.fn.line ".", vim.fn.line "v" } end,
            desc = "Reset Git hunk",
          },

          -- gitlinker
          ["<Leader>gy"] = { "<cmd>GitLink current_branch<cr>", desc = "Yank git link" },
          ["<Leader>gY"] = { "<cmd>GitLink! current_branch<cr>", desc = "Open git link" },
        },
        o = {
          ["ih"] = { ":<C-U>Gitsigns select_hunk<CR>", desc = "inside Git hunk" },
        },
        x = {
          ["ih"] = { ":<C-U>Gitsigns select_hunk<CR>", desc = "inside Git hunk" },
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
}
