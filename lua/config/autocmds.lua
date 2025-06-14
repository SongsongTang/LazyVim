-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- auto set .v and .sv filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.v", "*.vh" },
    callback = function()
        vim.bo.filetype = "verilog"
    end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.sv" },
    callback = function()
        vim.bo.filetype = "systemverilog"
    end,
})

-- auto remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.v", "*.sv" },
    callback = function()
        vim.cmd([[silent! %s/\s\+$//e]])
    end,
})
