return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = { "c", "lua", "rust" },
                highlight = { enable = true, }
            }
        end
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
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
                }
            }
        },
    },
}
