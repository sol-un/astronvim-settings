require("snacks")

return {
    "folke/snacks.nvim",
    event = "VeryLazy",
    ---@type snacks.Config
    opts = {
        picker = {
            sources = {
                explorer = {
                    hidden = true,
                    ignored = true,
                    layout = {
                        fullscreen = false,
                        preview = "main",
                    },
                },
                select = { layout = { fullscreen = false } },
                lines = { layout = { fullscreen = false } },
                files = {
                    hidden = true,
                    ignored = true,
                },
                grep = { hidden = true },
                grep_word = { hidden = true },
                recent = { hidden = true, ignored = true },
            },
            layout = {
                fullscreen = true,
            },
        },
    },
}
