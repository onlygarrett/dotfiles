return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		animate = {
			enabled = true,
			duration = 20, -- ms per step
			easing = "linear",
			fps = 60,
		},
		bigfile = { enabled = true },
		dashboard = { enabled = false },
		indent = {
			enabled = true,
			priority = 1,
			only_scope = false,
			only_current = false,
			hl = {
				"SnacksIndent1",
				"SnacksIndent2",
				"SnacksIndent3",
				"SnacksIndent4",
				"SnacksIndent5",
				"SnacksIndent6",
				"SnacksIndent7",
				"SnacksIndent8",
			},
		},
		input = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
	},
}
