return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local cappa = vim.lsp.protocol.make_client_capabilities()
		cappa.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}
		local capabilities = vim.tbl_deep_extend("force", {}, cappa, cmp_lsp.default_capabilities())

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"html",
				"cssls",
				"emmet_ls",
				"jsonls",
				"pyright",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				zls = function()
					local lspconfig = require("lspconfig")
					lspconfig.zls.setup({
						root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
						settings = {
							zls = {
								enable_inlay_hints = true,
								enable_snippets = true,
								warn_style = true,
							},
						},
					})
					vim.g.zig_fmt_parse_errors = 0
					vim.g.zig_fmt_autosave = 0
				end,
				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = { version = "Lua 5.1" },
								diagnostics = {
									globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
								},
							},
						},
					})
				end,
			},
		})

		require("mason-lspconfig").setup_handlers({
			function(server_name) -- default handler (optional)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["yamlls"] = function()
				require("lspconfig").yamlls.setup({
					capabilities = capabilities,
					settings = {
						yaml = {
							schemas = {
								kubernetes = "/*.yaml",
								["http://json.schemastore.org/composer"] = "/*",
								["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
								["../path/relative/to/file.yml"] = "/.github/workflows/*",
								["/path/from/root/of/project"] = "/.github/workflows/*",
							},
						},
					},
				})
			end,
			["dockerls"] = function()
				require("lspconfig").dockerls.setup({
					settings = {
						docker = {
							languageserver = {
								formatter = {
									ignoreMultilineInstructions = true,
								},
							},
						},
					},
				})
			end,
		})
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}

-- return {
-- 	"neovim/nvim-lspconfig",
-- 	event = { "BufReadPre", "BufNewFile" },
-- 	dependencies = {
-- 		"hrsh7th/cmp-nvim-lsp",
-- 		{ "antosha417/nvim-lsp-file-operations", config = true },
-- 		{ "folke/neodev.nvim", opts = {} },
-- 	},
-- 	config = function()
-- 		-- import lspconfig plugin
-- 		local lspconfig = require("lspconfig")

-- 		-- import mason_lspconfig plugin
-- 		local mason_lspconfig = require("mason-lspconfig")

-- 		-- import cmp-nvim-lsp plugin
-- 		local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- 		local keymap = vim.keymap -- for conciseness

-- 		vim.api.nvim_create_autocmd("LspAttach", {
-- 			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
-- 			callback = function(ev)
-- 				-- Buffer local mappings.
-- 				-- See `:help vim.lsp.*` for documentation on any of the below functions
-- 				local opts = { buffer = ev.buf, silent = true }

-- 				-- set keybinds
-- 				opts.desc = "Show LSP references"
-- 				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

-- 				opts.desc = "Go to declaration"
-- 				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

-- 				opts.desc = "Show LSP definitions"
-- 				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

-- 				opts.desc = "Show LSP implementations"
-- 				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

-- 				opts.desc = "Show LSP type definitions"
-- 				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

-- 				opts.desc = "See available code actions"
-- 				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

-- 				opts.desc = "Smart rename"
-- 				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

-- 				opts.desc = "Show buffer diagnostics"
-- 				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

-- 				opts.desc = "Show line diagnostics"
-- 				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

-- 				opts.desc = "Go to previous diagnostic"
-- 				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

-- 				opts.desc = "Go to next diagnostic"
-- 				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

-- 				opts.desc = "Show documentation for what is under cursor"
-- 				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

-- 				opts.desc = "Restart LSP"
-- 				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
-- 			end,
-- 		})

-- 		-- used to enable autocompletion (assign to every lsp server config)
-- 		local capabilities = cmp_nvim_lsp.default_capabilities()

-- 		-- Change the Diagnostic symbols in the sign column (gutter)
-- 		-- (not in youtube nvim video)
-- 		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
-- 		for type, icon in pairs(signs) do
-- 			local hl = "DiagnosticSign" .. type
-- 			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
-- 		end

-- 		mason_lspconfig.setup_handlers({
-- 			-- default handler for installed servers
-- 			function(server_name)
-- 				lspconfig[server_name].setup({
-- 					capabilities = capabilities,
-- 				})
-- 			end,
-- 			-- configure html server
-- 			["html"] = function()
-- 				lspconfig["html"].setup({
-- 					capabilities = capabilities,
-- 					filetypes = { "html" },
-- 				})
-- 			end,
-- 			["cssls"] = function()
-- 				-- configure cssls language server
-- 				lspconfig["cssls"].setup({
-- 					capabilities = capabilities,
-- 					filetypes = { "css", "sass", "scss" },
-- 				})
-- 			end,
-- 			["pyright"] = function()
-- 				-- configure py language server
-- 				lspconfig["pyright"].setup({
-- 					capabilities = capabilities,
-- 					filetypes = { "python" },
-- 				})
-- 			end,
-- 			["jsonls"] = function()
-- 				-- configure py json server
-- 				lspconfig["jsonls"].setup({
-- 					capabilities = capabilities,
-- 					filetypes = { "json" },
-- 				})
-- 			end,
-- 			["lua_ls"] = function()
-- 				-- configure lua server (with special settings)
-- 				lspconfig["lua_ls"].setup({
-- 					capabilities = capabilities,
-- 					settings = {
-- 						Lua = {
-- 							-- make the language server recognize "vim" global
-- 							diagnostics = {
-- 								globals = { "vim" },
-- 							},
-- 							completion = {
-- 								callSnippet = "Replace",
-- 							},
-- 						},
-- 					},
-- 				})
-- 			end,
-- 		})
-- 	end,
-- }
