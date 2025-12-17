return {
    {
        "GCBallesteros/jupytext.nvim",
        -- ft = { "ipynb" },
        opts = {
            style = "markdown",
            output_extension = "md",
            force_ft = "markdown",
        },
    },
    { "jmbuhr/otter.nvim", ft = { "markdown", "quarto", "norg" } },
    {
        "quarto-dev/quarto-nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvimtools/hydra.nvim",
            "jmbuhr/otter.nvim",
        },
        ft = { "quarto", "markdown", "norg" },
        config = function()
            local quarto = require("quarto")
            quarto.setup({
                lspFeatures = {
                    languages = { "python", "rust", "lua" },
                    chunks = "all", -- 'curly' or 'all'
                    diagnostics = {
                        enabled = true,
                        triggers = { "BufWritePost" },
                    },
                    completion = {
                        enabled = true,
                    },
                },
                keymap = {
                    hover = "H",
                    definition = "gd",
                    rename = "<localleader>rn",
                    references = "gr",
                    format = "<localleader>gf",
                },
                codeRunner = {
                    enabled = true,
                    ft_runners = {
                        bash = "slime",
                    },
                    default_method = "molten",
                },
            })

            vim.keymap.set(
                "n",
                "<localleader>qp",
                quarto.quartoPreview,
                { desc = "Preview the Quarto document", silent = true, noremap = true }
            )
            -- to create a cell in insert mode, I have the ` snippet
            vim.keymap.set("n", "<localleader>cc", "i`<c-j>", { desc = "Create a new code cell", silent = true })
            vim.keymap.set(
                "n",
                "<localleader>cs",
                "i```\r\r```{}<left>",
                { desc = "Split code cell", silent = true, noremap = true }
            )

            -- for more keybinds that I would use in a quarto document, see the configuration for molten
            -- require("benlubas.hydra.notebook")
        end,
    },
    {
        "benlubas/molten-nvim",
        -- enabled = false,
        dependencies = { "willothy/wezterm.nvim" },
        ft = { "python", "norg", "markdown", "quarto" }, -- this is just to avoid loading image.nvim, loading molten at the start has minimal startup time impact
        -- dev = true,
        init = function()
            -- if IsLinux() then -- xdg-open doesn't work on NixOS from within programs
            --     vim.g.molten_open_cmd = "firefox"
            -- end

            -- vim.g.molten_cover_empty_lines = true
            -- vim.g.molten_comment_string = "# %%"
            vim.keymap.set({ "v", "n" }, "<localleader><localleader>R", "<Cmd>MoltenEvaluateVisual<CR>")

            -- vim.g.molten_show_mimetype_debug = true
            vim.g.molten_auto_open_output = false
            vim.g.molten_image_location = "float"
            vim.g.molten_image_provider = "wezterm"
            vim.g.molten_output_show_more = true
            vim.g.molten_output_win_border = { "", "━", "", "" }
            vim.g.molten_output_virt_lines = true
            vim.g.molten_output_win_max_height = 50
            vim.g.molten_virt_text_output = true
            vim.g.molten_use_border_highlights = true
            vim.g.molten_virt_lines_off_by_1 = true
            vim.g.molten_wrap_output = true
            vim.g.molten_tick_rate = 142
            vim.g.molten_split_direction = "right" --direction of the output window, options are "right", "left", "top", "bottom"
            vim.g.molten_split_size = 40 --(0-100) % size of the screen dedicated to the output window
            vim.g.molten_auto_image_popup = true

            vim.keymap.set("n", "<leader>j", "", { desc = "Jupyter Notebook", silent = true, noremap = true })
            vim.keymap.set("n", "<leader>ja", function()
                vim.cmd("MoltenInit")
                vim.cmd("QuartoActivate")
            end, { desc = "Activate Jupyter notebook", silent = true, noremap = true })

            vim.keymap.set("n", "<leader>jmi", ":MoltenInit<CR>", { desc = "Initialize Molten", silent = true })
            vim.keymap.set("n", "<leader>jir", function()
                vim.cmd("MoltenInit rust")
            end, { desc = "Initialize Molten for Rust", silent = true })
            vim.keymap.set("n", "<leader>jip", function()
                local venv = os.getenv("VIRTUAL_ENV")
                if venv ~= nil then
                    -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
                    venv = string.match(venv, "/.+/(.+)")
                    vim.cmd(("MoltenInit %s"):format(venv))
                else
                    vim.cmd("MoltenInit python3")
                end
            end, { desc = "Initialize Molten for python3", silent = true, noremap = true })

            vim.api.nvim_create_autocmd("User", {
                pattern = "MoltenInitPost",
                callback = function()
                    -- quarto code runner mappings
                    local r = require("quarto.runner")
                    vim.keymap.set("n", "<localleader>rc", r.run_cell, { desc = "Run cell", silent = true })
                    vim.keymap.set("n", "<localleader>ra", r.run_above, { desc = "Run cell and above", silent = true })
                    vim.keymap.set("n", "<localleader>rb", r.run_below, { desc = "Run cell and below", silent = true })
                    vim.keymap.set(
                        "n",
                        "<localleader>ri",
                        "MoltenInterrupt<CR>",
                        { desc = "Run interrupt", silent = true }
                    )
                    vim.keymap.set("n", "<localleader>rl", r.run_line, { desc = "Run line", silent = true })
                    vim.keymap.set("n", "<localleader>rA", r.run_all, { desc = "Run all cells", silent = true })
                    vim.keymap.set("n", "<localleader>RA", function()
                        r.run_all(true)
                    end, { desc = "run all cells of all languages", silent = true })

                    -- setup some molten specific keybindings
                    vim.keymap.set(
                        "n",
                        "<localleader>mrc",
                        ":MoltenReevaluateCell<CR>",
                        { desc = "re-eval cell", silent = true }
                    )
                    vim.keymap.set(
                        "v",
                        "<localleader>mev",
                        ":<C-u>MoltenEvaluateVisual<CR>gv",
                        { desc = "execute visual selection", silent = true }
                    )
                    vim.keymap.set(
                        "n",
                        "<localleader>mo",
                        ":noautocmd MoltenEnterOutput<CR>",
                        { desc = "open output window", silent = true }
                    )
                    vim.keymap.set(
                        "n",
                        "<localleader>md",
                        ":MoltenDelete<CR>",
                        { desc = "delete Molten cell", silent = true }
                    )
                    -- 单行执行（REPL 风格）
                    vim.keymap.set(
                        "n",
                        "<localleader>mrl",
                        ":MoltenEvaluateLine<CR>",
                        { desc = "Molten: Evaluate current line", silent = true }
                    )
                    local open = false
                    vim.keymap.set("n", "<localleader>ot", function()
                        open = not open
                        vim.fn.MoltenUpdateOption("auto_open_output", open)
                    end)

                    -- if we're in a python file, change the configuration a little
                    if vim.bo.filetype == "python" then
                        vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", false)
                        vim.fn.MoltenUpdateOption("molten_virt_text_output", false)
                    end
                end,
            })

            -- change the configuration when editing a python file
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "*.py",
                callback = function(e)
                    if string.match(e.file, ".otter.") then
                        return
                    end
                    if require("molten.status").initialized() == "Molten" then
                        vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", false)
                        vim.fn.MoltenUpdateOption("molten_virt_text_output", false)
                    end
                end,
            })

            -- Undo those config changes when we go back to a markdown or quarto file
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = { "*.qmd", "*.md", "*.ipynb" },
                callback = function()
                    if require("molten.status").initialized() == "Molten" then
                        vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", true)
                        vim.fn.MoltenUpdateOption("molten_virt_text_output", true)
                    end
                end,
            })

            local imb = function(e)
                vim.schedule(function()
                    local kernels = vim.fn.MoltenAvailableKernels()

                    local try_kernel_name = function()
                        local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
                        return metadata.kernelspec.name
                    end
                    local ok, kernel_name = pcall(try_kernel_name)

                    if not ok or not vim.tbl_contains(kernels, kernel_name) then
                        kernel_name = nil
                        local venv = os.getenv("VIRTUAL_ENV")
                        if venv ~= nil then
                            kernel_name = string.match(venv, "/.+/(.+)")
                        end
                    end

                    if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
                        vim.cmd(("MoltenInit %s"):format(kernel_name))
                    end
                    vim.cmd("MoltenImportOutput")
                end)
            end

            -- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
            --   vim.api.nvim_create_autocmd("BufEnter", {
            --     pattern = { "*.ipynb" },
            --     callback = function(e)
            --       if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
            --         imb(e)
            --       end
            --     end,
            --   })
            --
            --   -- automatically import output chunks from a jupyter notebook
            --   vim.api.nvim_create_autocmd("BufAdd", {
            --     pattern = { "*.ipynb" },
            --     callback = imb,
            --   })
            --
            --   -- automatically export output chunks to a jupyter notebook
            --   vim.api.nvim_create_autocmd("BufWritePost", {
            --     pattern = { "*.ipynb" },
            --     callback = function()
            --       if require("molten.status").initialized() == "Molten" then
            --         vim.cmd("MoltenExportOutput!")
            --       end
            --     end,
            --   })
        end,
    },
}
