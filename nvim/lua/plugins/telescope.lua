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
            require("telescope.builtin").live_grep,
            mode = "",
            desc = "global fuzzy search",
        },
        {
            "<A-b>",
            require("telescope.builtin").buffers,
            mode = "",
            desc = "list buffers",
        },
    },
}
