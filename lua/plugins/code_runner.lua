return {
	"CRAG666/code_runner.nvim",
	event = "VeryLazy",
	config = function()
		require("code_runner").setup({
			-- FLOATING TERMINAL (REAL PTY)
			mode = "float",

			float = {
				border = "rounded",
				width = 0.85,
				height = 0.85,
				row = 0.5,
				col = 0.5,
			},

			filetype = {
				cpp = {
					[[bash -lc 'cd "$dir" && g++ -std=c++17 "$fileName" -O2 -Wall -o "$fileNameWithoutExt" && "./$fileNameWithoutExt"']],
				},
				c = {
					[[bash -lc 'cd "$dir" && gcc "$fileName" -O2 -Wall -o "$fileNameWithoutExt" && "./$fileNameWithoutExt"']],
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

		-- ALWAYS enter insert mode in terminal
		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "*",
			callback = function()
				vim.cmd("startinsert")
			end,
		})

		-- Normal run (interactive)
		vim.keymap.set(
			"n",
			"<F5>",
			"<cmd>RunCode<CR>",
			{ noremap = true, silent = true, desc = "Run code (floating, interactive)" }
		)

		-- Run with input.txt redirected
		vim.keymap.set("n", "<F6>", function()
			local ft = vim.bo.filetype
			local file = vim.fn.expand("%:t")
			local name = vim.fn.expand("%:t:r")
			local dir = vim.fn.expand("%:p:h")

			local cmd

			if ft == "cpp" then
				cmd = string.format(
					[[bash -lc 'cd "%s" && g++ -std=c++17 "%s" -O2 -Wall -o "%s" && "./%s" < input.txt']],
					dir,
					file,
					name,
					name
				)
			elseif ft == "c" then
				cmd = string.format(
					[[bash -lc 'cd "%s" && gcc "%s" -O2 -Wall -o "%s" && "./%s" < input.txt']],
					dir,
					file,
					name,
					name
				)
			elseif ft == "python" then
				cmd = string.format([[bash -lc 'cd "%s" && python3 "%s" < input.txt']], dir, file)
			end

			if cmd then
				vim.cmd("RunCode " .. vim.fn.shellescape(cmd))
			else
				vim.notify("No input-redirection runner for filetype: " .. ft, vim.log.levels.WARN)
			end
		end, { noremap = true, silent = true, desc = "Run code with input.txt (floating)" })
	end,
}
