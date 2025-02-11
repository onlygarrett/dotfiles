return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "ColorScheme",
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local colors = {
			blue = "#65D1FF",
			green = "#3EFFDC",
			violet = "#FF61EF",
			yellow = "#FFDA7B",
			red = "#FF4A4A",
			fg = "#c3ccdc",
			bg = "#112638",
			inactive_bg = "#2c3043",
		}

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				--- @usage 'rose-pine' | 'rose-pine-alt'
				theme = "rose-pine",
				disabled_filetypes = {
					statusline = { "alpha" },
					winbar = { "alpha", "Trouble", "spectre_panel", "noice" },
				},
			},
			sections = {
				lualine_x = {
					{
						function()
							return require("noice").api.status.command.get()
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.command.has()
						end,
						color = { bg = colors.teal, fg = colors.bg, gui = "bold" },
					},
					{
						function()
							return require("noice").api.status.mode.get()
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.mode.has()
						end,
						color = { bg = colors.orange, fg = colors.bg, gui = "bold" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
