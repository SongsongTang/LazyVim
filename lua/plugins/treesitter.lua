return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "InsertEnter",
        opts = function(_, opts)
            opts.ensure_installed = { "verilog" }
        end,
    },
}
