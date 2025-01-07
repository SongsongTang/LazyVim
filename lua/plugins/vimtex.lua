return {
    "lervag/vimtex",
    lazy = false, -- lazy-loading will disable inverse search
    config = function()
        vim.api.nvim_create_autocmd({ "FileType" }, {
            group = vim.api.nvim_create_augroup("lazyvim_vimtex_conceal", { clear = true }),
            pattern = { "bib", "tex" },
            callback = function()
                vim.wo.conceallevel = 0
            end,
        })
        vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
        vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"

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
