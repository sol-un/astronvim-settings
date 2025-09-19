return {
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
    },
    branch = "has-xml-tools",
    opts = {
      strategies = {
        chat = {
          adapter = "openai_compatible",
        },
      },
      adapters = {
        opts = { show_defaults = false },
        openai_compatible = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            formatted_name = "Kontur AI",
            env = {
              url = "https://srs-litellm.kontur.host",
              api_key = "KONTURAI_API_KEY",
              models_endpoint = "/v1/models",
              chat_url = "/v1/chat/completions",
            },
            schema = { model = { default = "preview-code-pro" } },
          })
        end,
      },
      display = {
        diff = {
          enabled = false,
        },
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            keymap = "<leader>ah",
            auto_save = true,
            expiration_days = 0,
            picker = "snacks",
            auto_generate_title = true,
            continue_last_chat = false,
            delete_on_clearing_chat = false,
            dir_to_save = vim.fn.stdpath "data" .. "/codecompanion-history",
            enable_logging = false,
          },
        },
      },
    },
    keys = {
      { "<leader>a", mode = { "n" }, desc = "CodeCompanion AI" },
      { "<leader>ac", mode = { "n" }, "<cmd>CodeCompanionChat<cr>i", desc = "Start a chat" },
      {
        "<leader>ae",
        mode = { "n" },
        "<cmd>CodeCompanionChat<cr>i@editor #buffer{watch} ",
        desc = "Edit current buffer",
      },
      { "<leader>ap", mode = { "n" }, "<cmd>CodeCompanionActions<cr>", desc = "Action palette..." },
      { "<leader>ac", mode = { "v" }, "<cmd>CodeCompanionChat Add<cr>i", desc = "Paste selection into chat" },
      { "<leader>ah", mode = { "n" }, "<cmd>CodeCompanionHistory<cr>", desc = "Chat history..." },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { { "<leader>a", icon = "" } },
      },
    },
  },
}
