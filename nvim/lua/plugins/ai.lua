return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
            file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
    },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        build = "make",
        ---@module 'avante'
        ---@type avante.Config
        opts = {
            mode = "legacy",
            provider = "claude",
            providers = {
                claude = {
                    endpoint = "https://api.anthropic.com",
                    model = "claude-sonnet-4-20250514",
                    extra_request_body = {
                        temperature = 0.75,
                        max_tokens = 4096,
                        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
                    },
                },
            },
            input = {
                provider = "snacks",
                provider_opts = {
                    -- Additional snacks.input options
                    title = "Avante Input",
                    icon = " ",
                },
            }
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "folke/snacks.nvim",             -- for input provider snacks
            "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
            'MeanderingProgrammer/render-markdown.nvim',
        },
    }
}
