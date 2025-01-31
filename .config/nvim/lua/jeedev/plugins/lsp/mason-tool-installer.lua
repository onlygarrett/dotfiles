return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	config = function()
		local mason_tool_installer = require("mason-tool-installer")
		-- enable mason and configure icons
		mason_tool_installer.setup({
			ensure_installed = {
                "lua-language-server",
                "stylua",
                "css-lsp",
                "emmet-ls",
                "html-lsp",
                "json-lsp",
                "lua-language-server",
                "prettier",
                "prettierd",
                "isort", -- python formatter
                "black", -- python formatter
                "pylint",
                "flake8",
                "mypy",
                "eslint_d",
                "typescript-language-server",
                "yaml-language-server",
            },
			auto_update = false,
            run_on_start = true,
            start_delay = 3000, -- 3 second delay
            debounce_hours = 5, -- at least 5 hours between attempts to install/update
		})
	end,
}
