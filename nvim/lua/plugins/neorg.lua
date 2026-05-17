return {
    {
        "nvim-neorg/neorg",
        lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
        version = "*", -- Pin Neorg to the latest stable release
        config = true,
        dependencies = {
            'nvim-neorg/tree-sitter-norg',
            'nvim-neorg/tree-sitter-norg-meta',
            "3rd/image.nvim",
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
                ['core.esupports.metagen'] = {
                    config = {
                        author = "ithyx"
                    }
                }
            },
        },
    },
    {
        "3rd/image.nvim",
        build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
        opts = {
            processor = "magick_cli",
        }
    }
}
