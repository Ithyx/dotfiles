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
        "xiyaowong/transparent.nvim",
        name = "transparent",
        lazy = false,
    },
    { "nvim-tree/nvim-web-devicons", opts = {} },
    { "lewis6991/gitsigns.nvim",     opts = {} },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                theme = 'catppuccin'
            },
            sections = {
                lualine_c = { { 'filename', file_status = true, path = 1 } }
            },
            inactive_sections = {
                lualine_c = { { 'filename', file_status = true, path = 1 } }
            },
            extensions = { 'toggleterm' }
        }
    }
}
