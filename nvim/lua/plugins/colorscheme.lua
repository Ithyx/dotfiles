vim.api.nvim_command('set termguicolors')
vim.api.nvim_command('set signcolumn=yes')
vim.api.nvim_command('set number')

return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin-mocha")
        end
    },
    {
        "xiyaowong/transparent.nvim", name = "transparent", lazy = false
    },
    { "nvim-tree/nvim-web-devicons", opts = {} },
}
