return {
    "lervag/vimtex",
    -- lazy = false, -- lazy-loading will disable inverse search
    ft = "latex",
    config = function()
        -- viewer method:
        vim.g.vimtex_view_method = "sioyek"
        -- Or with a generic interface:
        -- vim.g.vimtex_view_general_viewer = "okular"
        -- vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
        -- vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"

        vim.g.vimtex_compiler_latexmk = {
            aux_dir = "./out",
            out_dir = "./out",
            options = {
                "-shell-escape",
                "-verbose",
                "-file-line-error",
                "-synctex=1",
                "-interaction=nonstopmode",
                "-recorder",
            },
        }
    end,
}
