return {
    -- disable nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        optional = true,
        enabled = false,
    },
    {
        "saghen/blink.cmp",
        event = "InsertEnter",
        opts = {
            completion = {
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = true,
                    },
                },
            },
            keymap = {
                preset = "none",
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-e>"] = { "hide", "fallback" },
                ["<CR>"] = { "accept", "fallback" },

                ["<C-n>"] = { "snippet_forward", "fallback" },
                ["<C-p>"] = { "snippet_backward", "fallback" },

                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
                ["<Tab>"] = { "select_next", "fallback" },

                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },

                ["<C-y>"] = { LazyVim.cmp.map({ "snippet_forward", "ai_accept" }), "fallback" },
            },
        },
    },
}
