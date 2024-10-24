return {
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                ["cpp"] = { "clang_format" },
                ["c"] = { "clang_format" },
            },
            formatters = {
                clang_format = {
                    prepend_args = { "-style=Microsoft" },
                },
            },
        },
    },
}
