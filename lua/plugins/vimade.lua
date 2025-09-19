IS_FOCUSED = true

vim.api.nvim_create_autocmd("FocusGained", {
    callback = function()
        IS_FOCUSED = true
    end,
})
vim.api.nvim_create_autocmd("FocusLost", {
    callback = function()
        IS_FOCUSED = false
    end,
})

return {
    {
        "TaDaa/vimade",
        event = "VeryLazy",
        opts = {
            recipe = { "default", { animate = true } },
            ncmode = "buffers",
            enablefocusfading = true,
            usecursorhold = true,
            blocklist = {
                -- As long as the editor is focused, never fade windows in a tab that has a DiffviewFiles type buffer, as defined by the sindrets/diffview.nvim plugin
                diffview_tab = function()
                    if not IS_FOCUSED then
                        return false
                    end

                    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        if vim.api.nvim_get_option_value("filetype", { buf = buf }) == "DiffviewFiles" then
                            return true
                        end
                    end

                    return false
                end,
            },
        },
        keys = {
            {
                "<leader>uv",
                "<cmd>VimadeToggle<cr>",
            },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            spec = {
                {
                    {
                        "<leader>uv",
                        icon = function()
                            if vim.g.vimade_running == 1 then
                                return { icon = " ", color = "green" }
                            else
                                return { icon = " ", color = "yellow" }
                            end
                        end,
                        desc = function()
                            if vim.g.vimade_running == 1 then
                                return "Disable vimade"
                            else
                                return "Enable vimade"
                            end
                        end,
                    },
                },
            },
        },
    },
}
