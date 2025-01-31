return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
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

		local luasnip = require("luasnip")

		local lspkind = require("lspkind")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "copilot" },
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),

			formatting = {
				-- Set order from left to right
				-- kind: single letter indicating the type of completion
				-- abbr: abbreviation of "word"; when not empty it is used in the menu instead of "word"
				-- menu: extra text for the popup menu, displayed after "word" or "abbr"
				fields = { "abbr", "menu" },

				-- customize the appearance of the completion menu
				format = function(entry, vim_item)
					vim_item.menu = ({
						nvim_lsp = "[Lsp]",
						luasnip = "[Luasnip]",
						buffer = "[File]",
						path = "[Path]",
					})[entry.source.name]
					return vim_item
				end,
			},
			-- configure lspkind for vs-code like pictograms in completion menu
			-- formatting = {
			-- 	format = lspkind.cmp_format({
			-- 		maxwidth = 50,
			-- 		ellipsis_char = "...",
			-- 	}),
			-- },
		})
	end,
}
