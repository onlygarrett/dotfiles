return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		no_overlap = true,
		-- your configuration comes here
		height = { min = 6, max = 25 },
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
}
