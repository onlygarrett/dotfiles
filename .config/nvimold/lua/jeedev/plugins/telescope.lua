return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"debugloop/telescope-undo.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-file-browser.nvim",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local undo_actions = require("telescope-undo.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<esc>"] = actions.close,
						["<C-d>"] = actions.delete_buffer + actions.move_to_top,
					},
				},
				layout_config = {
					vertical = { preview_cutoff = 120 },
				},
				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			},
			extensions = {
				undo = {
					use_delta = true,
					side_by_side = true,
					entry_format = "󰣜  #$ID, $STAT, $TIME",
					layout_strategy = "flex",
					mappings = {
						i = {
							["<cr>"] = undo_actions.yank_additions,
							["<c-\\>"] = undo_actions.yank_deletions,
							["§"] = undo_actions.restore, -- term mapped to shift+enter
						},
					},
				},
				file_browser = {
					depth = false,
					auto_depth = true,
					hidden = { file_browser = true, folder_browser = true },
					hide_parent_dir = false,
					collapse_dirs = false,
					prompt_path = false,
					quiet = false,
					dir_icon = "󰉓 ",
					use_fd = true,
					dir_icon_hl = "Default",
					display_stat = { date = true, size = true, mode = true },
					git_status = true,
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("undo")
		telescope.load_extension("file_browser")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>sb", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
		keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>", { desc = "undo tree" })
		keymap.set("n", "<leader>fb", function()
			telescope.extensions.file_browser.file_browser()
		end, { desc = "browse files" })
	end,
}
