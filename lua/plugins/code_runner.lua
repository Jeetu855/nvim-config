return {
	"CRAG666/code_runner.nvim",
	config = function()
		require("code_runner").setup({
			mode = "float", -- run in floating terminal
			float = {
				border = "rounded",
				height = 0.8,
				width = 0.8,
				x = 0.5,
				y = 0.5,
			},
			filetype = {
				cpp = {
					[[bash -lc 'cd "$dir" && g++ -std=c++17 "$fileName" -o "$fileNameWithoutExt" \
          && "./$fileNameWithoutExt" ; rm -f "$fileNameWithoutExt"']],
				},
				c = {
					[[bash -lc 'cd "$dir" && gcc "$fileName" -o "$fileNameWithoutExt" \
          && "./$fileNameWithoutExt" ; rm -f "$fileNameWithoutExt"']],
				},
				python = {
					[[bash -lc 'cd "$dir" && python3 "$fileName"']],
				},
				go = {
					[[bash -lc 'cd "$dir" && go run "$fileName"']],
				},
				javascript = {
					[[bash -lc 'cd "$dir" && node "$fileName"']],
				},
			},
		})

		vim.keymap.set("n", "<F5>", "<cmd>RunCode<CR>", { desc = "Run code", noremap = true, silent = true })
	end,
	event = "VeryLazy",
}
