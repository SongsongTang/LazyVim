return {
    {
        -- Ensure C/C++ debugger is installed
        "williamboman/mason.nvim",
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
        opts = {
            -- make sure mason installs the server
            servers = {},
        },
    },
}
