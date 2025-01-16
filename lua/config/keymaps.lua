-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- DO NOT USE `LazyVim.safe_keymap_set` IN YOUR OWN CONFIG!!
-- use `vim.keymap.set` instead
local map = vim.keymap.set

-- -- diagnostic
local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end

-- Mapping for Errors
map("n", "ge", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "gE", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })

-- Mapping for Warnings
map("n", "gw", diagnostic_goto(true, "WARNING"), { desc = "Next Warning" })
map("n", "gW", diagnostic_goto(false, "WARNING"), { desc = "Prev Warning" })

-- Mapping for Hints
map("n", "gq", diagnostic_goto(true, "HINT"), { desc = "Next Hint" })
map("n", "gQ", diagnostic_goto(false, "HINT"), { desc = "Prev Hint" })

map("n", "qq", function()
    Snacks.bufdelete()
end, { desc = "Delete Buffer" })

-- Mapping Github Copilot
map("i", "<C-j>", 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true
map("i", "<C-l>", "<Plug>(copilot-accept-word)")
