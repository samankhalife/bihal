require("lazy").setup({
	-- General Plugins
	"tpope/vim-sleuth",
	-- UI & Theme Plugins ":colorscheme"
	-- require 'Saman.plugins.colorscheme',
	-- require 'Saman.plugins.catppuccin',
	require("Saman.plugins.indent_line"),
	require("Saman.plugins.nvim-tmux-navigation"),

	-- Completion & LSP Plugins
	require("Saman.plugins.cmp"),
	require("Saman.plugins.completions"),
	require("Saman.plugins.lspconfig"),
	require("Saman.plugins.conform"),
	require("Saman.plugins.mini"),

	-- File Explorer & Tree Plugins
	require("Saman.plugins.neo-tree"),
	require("Saman.plugins.snacks"),
	require("Saman.plugins.auto-session"),
    require("Saman.plugins.harpoon"),

	-- Git Plugins
	require("Saman.plugins.gitsigns"),

	-- Linting & Debugging Plugins
	require("Saman.plugins.lint"),
	require("Saman.plugins.debug"),

	-- Search & Navigation Plugins
	require("Saman.plugins.telescope"),
	require("Saman.plugins.which-key"),
	require("Saman.plugins.oil"),

	-- Text Editing & Code Management Plugins
	require("Saman.plugins.autopairs"),
	require("Saman.plugins.treesitter"),

	-- System & Utility Plugins
	--require 'Saman.plugins.health',
	require("Saman.plugins.none-ls"),
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
