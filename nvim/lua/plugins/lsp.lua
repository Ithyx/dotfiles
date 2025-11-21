return {
	{
		"neovim/nvim-lspconfig",
		init = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<F12>", builtin.lsp_definitions)
			vim.keymap.set("n", "gi", builtin.lsp_implementations)
			vim.keymap.set("n", "gr", builtin.lsp_references)
			vim.keymap.set("n", "<A-d>", builtin.diagnostics)

			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
						},
					},
				},
			})
			vim.lsp.config("tinymist", {
				settings = {
					formatterMode = "typstyle",
				},
			})
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
						},
					},
				},
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
			vim.filetype.add({
				extension = {
					frag = "glsl",
					vert = "glsl",
					comp = "glsl",
				},
			})
		end,
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				ensure_installed = { "c", "lua", "rust" },
				highlight = { enable = true },
				incremental_selection = { enable = true },
				indent = { enable = true },

				textobjects = {
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							-- You can optionally set descriptions to the mappings (used in the desc parameter of
							-- nvim_buf_set_keymap) which plugins like which-key display
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							-- You can also use captures from other query groups like `locals.scm`
							["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
						},
						-- You can choose the select mode (default is charwise 'v')
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * method: eg 'v' or 'o'
						-- and should return the mode ('v', 'V', or '<c-v>') or a table
						-- mapping query_strings to modes.
						-- selection_modes = {
						-- 	["@parameter.outer"] = "v", -- charwise
						-- 	["@function.outer"] = "V", -- linewise
						-- 	["@class.outer"] = "<c-v>", -- blockwise
						-- },
						-- If you set this to `true` (default is `false`) then any textobject is
						-- extended to include preceding or succeeding whitespace. Succeeding
						-- whitespace has priority in order to act similarly to eg the built-in
						-- `ap`.
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * selection_mode: eg 'v'
						-- and should return true or false
						-- include_surrounding_whitespace = true,
					},
				},
			})
		end,
	},
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{ "mason-org/mason.nvim", opts = {} },
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			"neovim/nvim-lspconfig",
			"mason-org/mason.nvim",
		},
	},
	{
		"fei6409/log-highlight.nvim",
		opts = {},
	},
}
