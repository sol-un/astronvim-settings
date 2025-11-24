return {
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
    },
    opts = {
      strategies = {
        chat = {
          adapter = "opencode",
        },
      },
      adapters = {
        acp = {
          opts = { show_defaults = false },
          opencode = function() return require "codecompanion.adapters.acp.opencode" end,
        },
        http = {
          opts = { show_defaults = false },
          openai_compatible = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              formatted_name = "Kontur AI",
              opts = { tools = true },
              env = {
                url = "OPENAI_HOST",
                api_key = "OPENAI_API_KEY",
                chat_url = "/chat/completions",
              },
              schema = { model = { default = "code-pro" } },
            })
          end,
        },
      },
      display = {
        chat = {
          fold_reasoning = true,
          show_reasoning = false,
        },
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            keymap = "<Leader>ah",
            auto_save = true,
            expiration_days = 0,
            picker = "snacks",
            auto_generate_title = true,
            continue_last_chat = false,
            dir_to_save = vim.fn.stdpath "data" .. "/codecompanion-history",
            title_generation_opts = { adapter = "openai_compatible" },
          },
        },
      },
    },
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>a"] = { desc = " AI" },
          ["<Leader>ac"] = { "<Cmd>CodeCompanionChat<cr>i", desc = "Start a chat" },
          ["<Leader>ae"] = {

            "<Cmd>CodeCompanionChat<cr>iUsing @{insert_edit_into_file} apply the following changes to the #{buffer}{watch}: ",
            desc = "Edit current buffer",
          },
          ["<Leader>ap"] = { "<Cmd>CodeCompanionActions<cr>", desc = "Action palette..." },
          ["<Leader>ah"] = { "<Cmd>CodeCompanionHistory<cr>", desc = "Chat history..." },
        },
        v = {
          ["<Leader>ac"] = { "<Cmd>CodeCompanionChat Add<cr>i", desc = "Paste selection into chat" },
        },
      },
    },
  },
}
