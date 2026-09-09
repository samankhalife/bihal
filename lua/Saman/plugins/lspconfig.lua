local servers = {
	"lua_ls",
	"emmet_language_server",
	"ts_ls",
	"gopls",
}

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "mason-org/mason.nvim", opts = {} },
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {
				ensure_installed = servers,
				automatic_enable = false,
			},
		},
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			opts = {
				ensure_installed = {
					"stylua",
					"prettier",
					"markdownlint",
					"erb-lint",
					"rubocop",
				},
				run_on_start = true,
				start_delay = 1000,
				debounce_hours = 24,
			},
		},
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				vim.keymap.set({ "n", "v" }, "<leader>vca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Show documentation for item under cursor"
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				vim.keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)

				opts.desc = "Show signature help"
				vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
			end,
		})

		local signs = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		}

		vim.diagnostic.config({
			signs = { text = signs },
			virtual_text = true,
			underline = true,
			update_in_insert = false,
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		vim.lsp.config("*", { capabilities = capabilities })

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		vim.lsp.config("emmet_language_server", {
			filetypes = {
				"css",
				"eruby",
				"html",
				"javascript",
				"javascriptreact",
				"less",
				"pug",
				"sass",
				"scss",
				"svelte",
				"typescriptreact",
			},
			init_options = {
				includeLanguages = {},
				excludeLanguages = {},
				extensionsPath = {},
				preferences = {},
				showAbbreviationSuggestions = true,
				showExpandedAbbreviation = "always",
				showSuggestionsAsSnippets = false,
				syntaxProfiles = {},
				variables = {},
			},
		})

		vim.lsp.config("ts_ls", {
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
			},
			single_file_support = true,
			init_options = {
				preferences = {
					includeCompletionsForModuleExports = true,
					includeCompletionsForImportStatements = true,
				},
			},
		})

		vim.lsp.config("gopls", {
			settings = {
				gopls = {
					analyses = { unusedparams = true },
					staticcheck = true,
					gofumpt = true,
				},
			},
		})

		vim.lsp.enable(servers)
	end,
}
