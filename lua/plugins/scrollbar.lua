return {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    opts = {
        show = true,
        handlers = { gitsigns = true },
        excluded_filetypes = {
            "snacks_picker_list",
            "snacks_picker_input",
            "snacks_input",
            "minifiles",
            "minifiles-help",
            "noice",
            "codecompanion",
            "DiffviewFiles",
            "gitcommit",
            "NeogitLogView",
            "NeogitStatus",
            "gitlab",
            "neotest-summary",
        },
        marks = {
            Cursor = {
                text = "┃",
            },
            Search = {
                text = { "│", "│" },
            },
            Error = {
                text = { "│", "│" },
            },
            Warn = {
                text = { "│", "│" },
            },
            Info = {
                text = { "│", "│" },
            },
            Hint = {
                text = { "│", "│" },
            },
            Misc = {
                text = { "│", "│" },
            },
            GitAdd = {
                text = "│",
            },
            GitChange = {
                text = "│",
            },
            GitDelete = {
                text = "│",
            },
        },
    },
}
