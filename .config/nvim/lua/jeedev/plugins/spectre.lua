local opts = {
	is_insert_mode = false,
}

return {
	"nvim-pack/nvim-spectre",
	opts = opts,
	cmd = "Spectre",
	keys = {
		{
			"<leader>S",
			'<cmd>lua require("spectre").toggle()<cr>',
			desc = "Toggle Spectre",
		},
		{
			"<leader>sw",
			'<cmd>lua require("spectre").open_visual({select_word=true})<cr>',
			desc = "Search current word",
		},
		{
			"<leader>sp",
			'<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
			desc = "Search on current file",
		},
	},
}
