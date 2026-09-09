return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = true,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_format = disable_filetypes[vim.bo[bufnr].filetype] and "never" or "fallback",
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier", stop_after_first = true },
				javascriptreact = { "prettier", stop_after_first = true },
				typescript = { "prettier", stop_after_first = true },
				typescriptreact = { "prettier", stop_after_first = true },
				css = { "prettier", stop_after_first = true },
				html = { "prettier", stop_after_first = true },
				json = { "prettier", stop_after_first = true },
				markdown = { "prettier", stop_after_first = true },
				yaml = { "prettier", stop_after_first = true },
				ruby = { "rubocop", stop_after_first = true },
			},
		},
	},
}
