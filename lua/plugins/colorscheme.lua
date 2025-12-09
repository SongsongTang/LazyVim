return {
    -- add gruvbox
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        opts = {
            contrast = "medium",
        },
        init = function()
            vim.o.background = "light"
        end,
    },

    -- Configure LazyVim to load gruvbox
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "gruvbox",
        },
    },
}
