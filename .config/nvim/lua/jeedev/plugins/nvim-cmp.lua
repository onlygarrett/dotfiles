return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
		{
			"zbirenbaum/copilot-cmp",
			opts = {},
		},
	},
	config = function()
		local cmp = require("cmp")
		local compare = require("cmp.config.compare")
		local luasnip = require("luasnip")
		local cmp_next = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true))
			else
				fallback()
			end
		end
		local cmp_prev = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true))
			else
				fallback()
			end
		end

		local lspkind = require("lspkind")
		lspkind.init({
			symbol_map = {
				Copilot = "",
			},
		})

		vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		local has_words_before = function()
			if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
				return false
			end
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
		end

		cmp.setup({
			enabled = true,
			preselect = cmp.PreselectMode.None,
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			view = {
				entries = "bordered",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				-- ["<Tab>"] = vim.schedule_wrap(function(fallback)
				-- 	if cmp.visible() and has_words_before() then
				-- 		cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				-- 	else
				-- 		fallback()
				-- 	end
				-- end),
				--
				-- ["<S-Tab>"] = cmp_prev,
				["<C-j>"] = cmp_next,
				["<C-k>"] = cmp_prev,
				["<down>"] = cmp_next,
				["<up>"] = cmp_prev,
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<S-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.close(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "copilot", group_index = 1, priority = 100 },
				{
					name = "nvim_lsp",
					max_item_count = 20,
					group_index = 1,
					option = {
						use_show_condition = true,
					},
				},
				{ name = "luasnip", max_item_count = 5, group_index = 1 }, -- snippets
				{ name = "buffer", max_item_count = 5, keyword_length = 2, group_index = 2 }, -- text within current buffer
				{ name = "path", group_index = 2 }, -- file system paths
				{ name = "cmdline" },
			}),

			sorting = {
				priority_weight = 2,
				comparators = {
					require("copilot_cmp.comparators").prioritize,
					compare.offset,
					compare.exact,
					compare.score,
					compare.recently_used,
					compare.kind,
					compare.sort_text,
					compare.length,
					compare.order,
				},
			},
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					max_width = 100,
					ellipsis_char = "...",
					show_labelDetails = true,
					symbol_map = {

						Copilot = "",
						Text = "",
						Method = "",

						Function = "",
						Constructor = "",
						Field = "",
						Variable = "",
						Class = "",
						Interface = "",
						Module = "",
						Property = "",
						Unit = "",
						Value = "",
						Enum = "",

						Keyword = "",
						Snippet = "",

						Color = "",
						File = "",
						Reference = "",
						Folder = "",
						EnumMember = "",
						Constant = "",
						Struct = "",
						Event = "",
						Operator = "",
						TypeParameter = "",
					},
				}),
			},
		})
		local presentAutoPairs, autopairs = pcall(require, "nvim-autopairs.completion.cmp")
		if not presentAutoPairs then
			return
		end
		cmp.event:on("confirm_done", autopairs.on_confirm_done({ map_char = { tex = "" } }))
	end,
}
