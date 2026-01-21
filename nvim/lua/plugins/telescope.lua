return {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    keys = {
        {
            "<A-f>",
            function() require("telescope.builtin").live_grep() end,
            mode = "",
            desc = "global fuzzy search",
        },
        {
            "<A-b>",
            function() require("telescope.builtin").buffers() end,
            mode = "",
            desc = "list buffers",
        },
    },
}
