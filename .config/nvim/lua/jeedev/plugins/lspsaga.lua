local keys = { quit = { "<esc>", "q" }, toggle_or_jump = { "<cr>", "o" } }

return {
	"nvimdev/lspsaga.nvim",
	event = "LspAttach",
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
	{
		"RRethy/vim-illuminate",
		opts = {
			filetypes_denylist = {
				"sagafinder",
				"sagacallhierarchy",
				"sagaincomingcalls",
				"sagapeekdefinition",
			},
		},
	},
	config = function()
		require("lspsaga").setup({
			opts = {
				preview = {
					lines_above = 0,
					lines_below = 10,
				},

				code_action = {
					enable = false,
					extend_gitsigns = true,
				},

				scroll_preview = {
					scroll_down = "<C-f>",
					scroll_up = "<C-b>",
				},
				request_timeout = 2000,

				lightbulb = {
					enable = false,
				},

				rename = {
					enable = false,
				},

				finder = {
					silent = true,
					{ quit = keys.quit, toggle_or_open = keys.toggle_or_jump },
				},

				diagnostic = {
					enable = false,
				},

				symbol_in_winbar = {
					enable = false,
					hide_keyword = false,
					show_file = true,
					folder_level = 0,
				},

				definition = {
					silent = true,
				},

				ui = {
					theme = "round",
					border = "rounded",
					winblend = 0,
					expand = "",
					collaspe = "",
					preview = " ",
					code_action = "󱧣 ",
					diagnostic = "🐞",
					hover = " ",
					kind = {},
				},

				outline = { enable = false, silent = true, keys = keys },
				callhierarchy = { silent = true, keys = { quit = keys.quit } },
			},
		})
		vim.keymap.set(
			"v",
			"<leader>la",
			"<cmd>Lspsaga code_action<cr>",
			{ desc = "Lspsaga | Code Action", silent = true }
		)
		vim.keymap.set(
			"n",
			"<leader>lo",
			"<cmd>Lspsaga outline<cr>",
			{ desc = "Lspsaga | Code Outline", silent = true }
		)
		vim.keymap.set(
			"n",
			"<leader>lI",
			"<cmd>Lspsaga incoming_calls<cr>",
			{ desc = "Lspsaga | Incoming Calls", silent = true }
		)
		vim.keymap.set(
			"n",
			"<leader>lO",
			"<cmd>Lspsaga outgoing_calls<cr>",
			{ desc = "Lspsaga | Outgoing Calls", silent = true }
		)
		vim.keymap.set("n", "<leader>ll", "<Cmd>Lspsaga finder<CR>", { desc = "Lspsaga finder", silent = true })
		vim.keymap.set(
			"n",
			"<leader>lp",
			"<Cmd>Lspsaga peek_definition<CR>",
			{ desc = "Lspsaga peek_definition", silent = true }
		)
		vim.keymap.set(
			"n",
			"<leader>ld",
			"<Cmd>Lspsaga peek_definition<CR>",
			{ desc = "Goto definition", silent = true }
		)
	end,
}
