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

-- 1) 定义 OverLength 高亮组的颜色
local function set_overlength_hl()
    -- 这里改成你喜欢的浅蓝色
    vim.api.nvim_set_hl(0, "OverLength", {
        bg = "#4a3f31",
    })
end

-- 注意：autocmds.lua 在 VeryLazy 加载，所以这里要直接调用一次
set_overlength_hl()

-- 换 colorscheme 时再重新设置一次，防止被主题覆盖掉
vim.api.nvim_create_autocmd("ColorScheme", {
    group = overlength_group,
    callback = function()
        set_overlength_hl()
    end,
})

-- 2) 为每个窗口加上“>120 列变色”的 match
vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
    group = overlength_group,
    callback = function()
        -- 从第 121 列开始到行尾：\%121v.\+
        vim.cmd([[match OverLength /\%121v.\+/]])
    end,
})
