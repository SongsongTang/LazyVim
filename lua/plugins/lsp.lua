return {
    {
        -- Ensure C/C++ debugger is installed
        "mason-org/mason.nvim",
        event = "InsertEnter",
        optional = true,
        opts = {
            ensure_installed = {
                "verible",
                "lua-language-server",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = "InsertEnter",
        opts = {
            -- make sure mason installs the server
            servers = {},
        },
    },
}
