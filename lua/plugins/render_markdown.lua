return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown", "quarto" }, -- load for these filetypes
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons", -- optional, for icons
	},
	opts = {
		max_file_size = 25.0,
		debounce = 250,
		file_types = { "markdown" },
		render_modes = true,
		padding = { left = 2, right = 2 },

		code = {
			sign = false,
			width = "block",
			right_pad = 1,
		},

		-- keep heading.icons *omitted* (DO NOT set icons = {}).
		-- Use `sign = false` to disable left sign column if you want,
		-- but leaving out `icons` lets the plugin render headings normally.
		heading = {
			sign = false,
		},

		checkbox = { enabled = true },
	},

	config = function(_, opts)
		require("render-markdown").setup(opts)
	end,
}
