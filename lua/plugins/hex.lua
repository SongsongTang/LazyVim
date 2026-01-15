return {
    "RaafatTurki/hex.nvim",
    event = "BufReadPre",
    cond = function()
        local name = vim.fn.expand("%:e")
        return name == "dat" or name == "exe"
    end,
    opts = {
        is_file_binary = function()
            return true
        end,
    },
}
