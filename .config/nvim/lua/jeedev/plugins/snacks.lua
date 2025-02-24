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
		explorer = { enabled = true, layout = { cycle = false } },
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
				{

					section = "terminal",
					cmd = "ascii-image-converter ~/Desktop/Others/profiles.JPG -C -c",

					random = 10,
					pane = 2,
					indent = 4,
					height = 30,
				},
			},
		},
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
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		quickfile = { enabled = true, exclude = { "latex" } },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		scroll = { enabled = false },
		picker = {
			enabled = true,
			formatters = {
				file = {
					filename_first = false,
					filename_only = false,
					icon_width = 2,
				},
			},
			layout = {
				-- presets options : "default" , "ivy" , "ivy-split" , "telescope" , "vscode", "select" , "sidebar"
				-- override picker layout in keymaps function as a param below
				preset = "telescope", -- defaults to this layout unless overidden
				cycle = false,
			},

			layouts = {
				select = {
					preview = false,

					layout = {
						backdrop = false,
						width = 0.6,
						min_width = 80,

						height = 0.4,
						min_height = 10,
						box = "vertical",
						border = "rounded",
						title = "{title}",
						title_pos = "center",
						{ win = "input", height = 1, border = "bottom" },

						{ win = "list", border = "none" },
						{ win = "preview", title = "{preview}", width = 0.6, height = 0.4, border = "top" },
					},
				},
				telescope = {
					reverse = true, -- set to false for search bar to be on top
					layout = {
						box = "horizontal",
						backdrop = false,
						width = 0.8,
						height = 0.9,

						border = "none",
						{
							box = "vertical",
							{ win = "list", title = " Results ", title_pos = "center", border = "rounded" },
							{
								win = "input",
								height = 1,
								border = "rounded",
								title = "{title} {live} {flags}",
								title_pos = "center",
							},
						},
						{
							win = "preview",
							title = "{preview:Preview}",
							width = 0.50,
							border = "rounded",
							title_pos = "center",
						},
					},
				},
				ivy = {
					layout = {
						box = "vertical",
						backdrop = false,
						width = 0,
						height = 0.4,
						position = "bottom",

						border = "top",

						title = " {title} {live} {flags}",
						title_pos = "left",
						{ win = "input", height = 1, border = "bottom" },
						{
							box = "horizontal",
							{ win = "list", border = "none" },
							{ win = "preview", title = "{preview}", width = 0.5, border = "left" },
						},
					},
				},
			},
		},
		styles = {
			notification = {
				wo = { wrap = true }, -- Wrap notifications
			},
		},
	},
	keys = {
		{
			"<leader>gf",
			function()
				Snacks.lazygit.log_file()
			end,
			desc = "Lazygit Current File History",
		},
		{
			"<leader>gl",
			function()
				Snacks.lazygit.log()
			end,
			desc = "Lazygit Log (cwd)",
		},
		{
			"<leader>rN",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename File",
		},
		{
			"<C-/>",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle Terminal",
		},
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
		{
			"<leader>es",
			function()
				require("snacks").explorer()
			end,
			desc = "Open Snacks Explorer",
		},
		{
			"<leader>N",

			desc = "Neovim News",
			function()
				Snacks.win({
					file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
					width = 0.6,
					height = 0.6,
					wo = {
						spell = false,

						wrap = false,
						-- signcolumn = "yes",
						statuscolumn = " ",
						conceallevel = 3,
					},
				})
			end,
		},
		-- Snacks Picker
		{
			"<leader>pf",
			function()
				require("snacks").picker.files()
			end,
			desc = "Find Files (Snacks Picker)",
		},
		{
			"<leader>pc",
			function()
				require("snacks").picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Config File",
		},
		{
			"<leader>ps",
			function()
				require("snacks").picker.grep()
			end,
			desc = "Grep word",
		},
		{
			"<leader>pws",
			function()
				require("snacks").picker.grep_word()
			end,
			desc = "Search Visual selection or Word",
			mode = { "n", "x" },
		},
		{
			"<leader>pk",
			function()
				require("snacks").picker.keymaps({ layout = "ivy" })
			end,
			desc = "Search Keymaps (Snacks Picker)",
		},
		{
			"<leader>th",
			function()
				require("snacks").picker.colorschemes({ layout = "ivy" })
			end,
			desc = "Pick Color Schemes",
		},
	},
	init = function()
		Snacks = require("snacks")

		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")

				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle
					.option("background", { off = "light", on = "dark", name = "Dark Background" })
					:map("<leader>ub")
				Snacks.toggle.inlay_hints():map("<leader>uh")
			end,
		})
	end,
}
