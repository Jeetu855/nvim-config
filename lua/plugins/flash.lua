return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				search = {
					enabled = true, -- enables flash when using / or ?
				},
				char = {
					enabled = true, -- enables f, F, t, T motions
					jump_labels = true, -- show labels while using them
				},
			},
		},
		keys = {
			{
				"zk",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash jump",
			},
			{
				"ZK",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote flash",
			},
			{
				"R",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Flash treesitter search",
			},
			{
				"<C-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
}
