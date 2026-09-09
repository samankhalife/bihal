return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		local sources = {}

		if vim.fn.executable("erb_lint") == 1 then
			table.insert(sources, null_ls.builtins.diagnostics.erb_lint)
		end

		if vim.fn.executable("rubocop") == 1 then
			table.insert(sources, null_ls.builtins.diagnostics.rubocop)
		end

		null_ls.setup({ sources = sources })
	end,
}
