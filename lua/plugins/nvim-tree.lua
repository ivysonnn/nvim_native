return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "File explorer" },
	},
	opts = {
		sync_root_with_cwd = true,
		respect_buf_cwd = true,
		diagnostics = {
			enable = true,
			show_on_dirs = false,
		},
		filters = {
			dotfiles = false,
			custom = { "node_modules", "%.cache", "dist", "build" },
		},
		git = {
			enable = true,
			ignore = true,
		},
		view = {
			adaptive_size = true,
			side = "left",
			width = 30,
		},
		renderer = {
			indent_markers = {
				enable = true,
			},
		},
	},
}
