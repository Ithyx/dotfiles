return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        {
            "<A-f>",
            require("telescope.builtin").live_grep,
            mode = "",
            desc = "global fuzzy search",
        },
    },
}
