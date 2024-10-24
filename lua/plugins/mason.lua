return {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
        ensure_installed = {
            "stylua",
            "shfmt",
            "clang-format",
            "clangd",
            "lua-language-server",
            "markdown-toc",
            "markdownlint-cli2",
            "marksman",
            "texlab",
        },
    },
}
