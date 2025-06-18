vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        init = function()
            vim.keymap.set(
                { "n", "t" },
                "th",
                '<Cmd>execute v:count . "ToggleTerm direction=horizontal"<CR>',
                {
                    desc = "Toggle terminal (docked horizontally)",
                    silent = true,
                })

            vim.keymap.set(
                { "n", "t" },
                "<A-t>",
                '<Cmd>execute v:count . "ToggleTerm direction=vertical"<CR>',
                {
                    desc = "Toggle terminal",
                    silent = true,
                })
            vim.keymap.set(
                { "n", "t" },
                "tv",
                '<Cmd>execute v:count . "ToggleTerm direction=vertical"<CR>',
                {
                    desc = "Toggle terminal (docked vertically)",
                    silent = true,
                })

            vim.keymap.set(
                { "n", "t" },
                "<A-S-t>",
                '<Cmd>execute v:count . "ToggleTerm direction=float"<CR>',
                {
                    desc = "Toggle float terminal",
                    silent = true,
                })
            vim.keymap.set(
                { "n", "t" },
                "tf",
                '<Cmd>execute v:count . "ToggleTerm direction=float"<CR>',
                {
                    desc = "Toggle terminal (floating)",
                    silent = true,
                })
        end,
        opts = {
            size = function(term)
                if term.direction == "horizontal" then
                    return 20
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.3
                end
            end,
            shade_terminals = false,
        },
    }
}
