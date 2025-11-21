return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			modes = {
				search = {
					-- when `true`, flash will be activated during regular search by default.
					-- You can always toggle when searching with `require("flash").toggle()`
					enabled = true,
					highlight = { backdrop = true },
					jump = { history = true, register = true, nohlsearch = true },
					search = {
						-- `forward` will be automatically set to the search direction
						-- `mode` is always set to `search`
						-- `incremental` is set to `true` when `incsearch` is enabled
					},
				},
                char = {
                    enabled = false,
                },
			},
		},
	},
}
