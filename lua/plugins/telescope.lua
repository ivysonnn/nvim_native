return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<leader>o", "<cmd>Telescope old_files<cr>", desc = "Recent files" },
		{ "<leader>F", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
	},
	opts = {
		sorter = "fzf",
		path_display = { "smart" },
		file_ignore_patterns = {
			"%.git/",
			"%.cache/",
			"%.tmp/",
			"node_modules/",
			"dist/",
			"build/",
			"%.log$",
		},
		layout_config = {
			horizontal = {
				prompt_position = "top",
				width = 0.9,
				height = 0.85,
			},
		},
	},
}
