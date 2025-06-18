return {
    {
        "neovim/nvim-lspconfig",
        init = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n",
                "<F12>",
                builtin.lsp_definitions
            )
            vim.keymap.set("n",
                "gi",
                builtin.lsp_implementations
            )
            vim.keymap.set("n",
                "gr",
                builtin.lsp_references
            )
            vim.keymap.set("n",
                "<A-d>",
                builtin.diagnostics
            )

            vim.lsp.config("rust_analyzer", {
                settings = {
                    ["rust-analyzer"] = {
                        check = {
                            command = "clippy"
                        }
                    }
                }
            })
        end,
        keys = {
            {
                "<C-s>",
                function()
                    vim.lsp.buf.format({ async = true })
                end,
                mode = "",
                desc = "Format buffer",
            },

            {
                "<F2>",
                vim.lsp.buf.rename,
                mode = "",
                desc = "Rename symbol",
            },
            {
                "<C-.>",
                vim.lsp.buf.code_action,
                mode = "",
                desc = "Code actions",
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        init = function()
            vim.filetype.add {
                extension = {
                    frag = 'glsl',
                    vert = 'glsl',
                    comp = 'glsl',
                }
            }
        end,
        config = function()
            require("nvim-treesitter.configs").setup {
                auto_install = true,
                ensure_installed = { "c", "lua", "rust" },
                highlight = { enable = true, },
                incremental_selection = { enable = true, },
                indent = { enable = true, },
            }
        end
    },
    { "mason-org/mason.nvim", opts = {} },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            "neovim/nvim-lspconfig",
            "mason-org/mason.nvim",
        }
    },
}
