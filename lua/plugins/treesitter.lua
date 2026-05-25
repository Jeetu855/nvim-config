return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "lua", "vim", "vimdoc", "c", "rust", "go" },
			highlight = { enable = true },
			indent = { enable = true },
		},
	},
}
