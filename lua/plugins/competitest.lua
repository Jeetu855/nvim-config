return {
	"xeluxee/competitest.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local competitest = require("competitest")

		competitest.setup({
			-- ---------- GENERAL ----------
			compile_command = {
				cpp = {
					exec = "g++",
					args = { "-std=c++17", "-O2", "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" },
				},
				c = {
					exec = "gcc",
					args = { "-O2", "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" },
				},
			},

			run_command = {
				cpp = { exec = "./$(FNOEXT)" },
				c = { exec = "./$(FNOEXT)" },
				python = { exec = "python3", args = { "$(FNAME)" } },
			},

			-- ---------- TESTCASES ----------
			testcases_directory = "testcases",
			testcases_use_single_file = false,
			testcases_auto_detect_storage = true,

			-- ---------- UI ----------
			ui = {
				width = 0.85,
				height = 0.85,
				border = "rounded",
			},

			-- ---------- BEHAVIOR ----------
			save_before_compile = true,
			save_before_run = true,
			compile_timeout = 5000,
			run_timeout = 5000,
		})

		-- -------------------------------
		-- Keymaps (minimal & logical)
		-- -------------------------------

		-- Keymaps (correct ones)
		local opts = { noremap = true, silent = true }

		vim.keymap.set(
			"n",
			"<leader>tc",
			"<cmd>CompetiTest add_testcase<CR>",
			vim.tbl_extend("force", opts, { desc = "Add testcase" })
		)

		vim.keymap.set(
			"n",
			"<leader>te",
			"<cmd>CompetiTest edit_testcase<CR>",
			vim.tbl_extend("force", opts, { desc = "Edit testcase" })
		)

		vim.keymap.set(
			"n",
			"<leader>tr",
			"<cmd>CompetiTest run<CR>",
			vim.tbl_extend("force", opts, { desc = "Run testcases" })
		)
	end,
}
