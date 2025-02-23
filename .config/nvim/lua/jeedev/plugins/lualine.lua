return {
	"nvim-lualine/lualine.nvim",

	enabled = true,
	lazy = false,
	event = { "BufReadPost", "BufNewFile", "VeryLazy" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",

				icons_enabled = true,

				component_separators = { left = " ", right = " " },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {

				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename", "harpoon2" },

				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},

			inactive_sections = {

				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},

			inactive_winbar = {},
			extensions = {},
		})
	end,
}
-- return {
-- 	"nvim-lualine/lualine.nvim",
-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
-- 	event = "ColorScheme",
-- 	config = function()
-- 		local lualine = require("lualine")
-- 		local lazy_status = require("lazy.status") -- to configure lazy pending updates count
--
-- 		local colors = {
-- 			blue = "#65D1FF",
-- 			green = "#3EFFDC",
-- 			violet = "#FF61EF",
-- 			yellow = "#FFDA7B",
-- 			red = "#FF4A4A",
-- 			fg = "#c3ccdc",
-- 			bg = "#112638",
-- 			inactive_bg = "#2c3043",
-- 		}
--
-- 		-- configure lualine with modified theme
-- 		lualine.setup({
-- 			options = {
-- 				--- @usage 'rose-pine' | 'rose-pine-alt'
-- 				theme = "rose-pine-alt",
-- 				disabled_filetypes = {
-- 					statusline = { "alpha" },
-- 					winbar = { "alpha", "Trouble", "spectre_panel", "noice" },
-- 				},
-- 				icons_enabled = true,
-- 				component_separators = "|",
-- 			},
-- 			sections = {
-- 				lualine_a = {
-- 					"filename",
-- 				},
-- 				-- lualine_c = {
-- 				-- 	-- ...other lualine components
-- 				-- 	{
-- 				-- 		require("tmux-status").tmux_windows,
-- 				-- 		cond = require("tmux-status").show,
-- 				-- 		padding = { left = 3 },
-- 				-- 	},
-- 				-- },
-- 				lualine_x = {
-- 					{
-- 						function()
-- 							return require("noice").api.status.command.get()
-- 						end,
-- 						cond = function()
-- 							return package.loaded["noice"] and require("noice").api.status.command.has()
-- 						end,
-- 						color = { bg = colors.teal, fg = colors.bg, gui = "bold" },
-- 					},
-- 					{
-- 						function()
-- 							return require("noice").api.status.mode.get()
-- 						end,
-- 						cond = function()
-- 							return package.loaded["noice"] and require("noice").api.status.mode.has()
-- 						end,
-- 						color = { bg = colors.orange, fg = colors.bg, gui = "bold" },
-- 					},
-- 					{ "encoding" },
-- 					{ "fileformat" },
-- 					{ "filetype" },
-- 				},
-- 				-- lualine_z = {
-- 				-- 	-- ...other lualine components
-- 				-- 	{
-- 				-- 		require("tmux-status").tmux_session,
-- 				-- 		cond = require("tmux-status").show,
-- 				-- 		padding = { left = 3 },
-- 				-- 	},
-- 				-- },
-- 			},
-- 		})
-- 	end,
-- }
