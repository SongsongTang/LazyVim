return {
    "lervag/vimtex",
    -- lazy = false, -- lazy-loading will disable inverse search
    ft = "latex",
    config = function()
        vim.g.vimtex_view_general_viewer = "SumatraPDF"
        --" Simpler alternatives for following option:
        vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"

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
