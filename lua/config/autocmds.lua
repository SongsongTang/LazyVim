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

local overlength_group = vim.api.nvim_create_augroup("OverLengthHighlight", { clear = true })

-- 1) Define OverLength highlight color
local function set_overlength_hl()
    vim.api.nvim_set_hl(0, "OverLength", {
        link = "ColorColumn",
        -- bg = "#3c3836",
        -- bg = "#ebdbb2",
    })
end

-- Note: autocmds.lua is loaded on the VeryLazy event, so we must call this once immediately.
set_overlength_hl()

-- Re-apply highlight settings after colorscheme changes to prevent them from being overwritten.
vim.api.nvim_create_autocmd("ColorScheme", {
    group = overlength_group,
    callback = function()
        set_overlength_hl()
    end,
})

-- Apply “>120 columns highlight” match for each window.
vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
    group = overlength_group,
    callback = function()
        -- Match from column 121 to the end of the line: \%121v.\+
        vim.cmd([[match OverLength /\%121v.\+/]])
    end,
})

-- Force * and # searches to be case-sensitive.
vim.keymap.set("n", "*", [[/\C\<\<<c-r><c-w>\>\><cr>]], { silent = true })
vim.keymap.set("n", "#", [[?\C\<\<<c-r><c-w>\>\><cr>]], { silent = true })
