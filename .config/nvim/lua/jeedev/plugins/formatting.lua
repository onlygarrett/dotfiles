return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "ConformInfo" },
	config = function()
		local conform = require("conform")
		local prettier = { "prettier", "prettierd", stop_after_match = true }

		conform.setup({
			default_format_opts = {
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				javascript = prettier,
				typescript = prettier,
				javascriptreact = prettier,
				typescriptreact = prettier,
				svelte = prettier,
				css = prettier,
				html = prettier,
				json = prettier,
				yaml = prettier,
				markdown = prettier,
				graphql = prettier,
				liquid = prettier,
				lua = { "stylua" },
				python = { "isort", "black" },
			},
			formatters = {
				prettier = {
					command = "prettier",
					prepend_args = { "-w" },
				},
				prettierd = {
					command = "prettierd",
					prepend_args = { "-w" },
				},
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})
	end,
	keys = {
		{
			"<leader>mp",
			function()
				require("conform").format({
					lsp_fallback = true,
					async = true,
					timeout_ms = 1000,
				})
			end,
			desc = "Format file",
		},
	},
}
