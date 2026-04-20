return {
    {
        "nvim-neorg/neorg",
        lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
        version = "*", -- Pin Neorg to the latest stable release
        config = true,
        dependencies = {
            'nvim-neorg/tree-sitter-norg',
            'nvim-neorg/tree-sitter-norg-meta',
        },

        opts = {
            load = {
                ['core.defaults'] = {},
                ['core.concealer'] = {},
                ['core.summary'] = {
                    config = {
                        strategy = "by_path",
                    }
                },
                ['core.dirman'] = {
                    config = {
                        workspaces = {
                            main = '~/notes/main/', -- Format: <name_of_workspace> = <path_to_workspace_root>
                            EA = '~/notes/EA/',
                        },
                        index = 'index.norg',
                        default_workspace = 'main',
                    },
                },
            },
        },
    }
}
