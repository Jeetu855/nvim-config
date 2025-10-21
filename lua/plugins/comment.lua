return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		local comment = require("Comment")
		local api = require("Comment.api")
		local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

		comment.setup({
			pre_hook = ts_context_commentstring.create_pre_hook(),
		})

		-- VS Code–style Ctrl+/ toggle
		-- Note: many terminals send Ctrl+/ as <C-_>. We map both.
		local opts_n = { noremap = true, silent = true, desc = "Toggle comment (current line)" }
		local opts_x = { noremap = true, silent = true, desc = "Toggle comment (visual selection)" }

		-- Normal mode: only the current line
		vim.keymap.set("n", "<C-_>", api.toggle.linewise.current, opts_n)
		vim.keymap.set("n", "<C-/>", api.toggle.linewise.current, opts_n)

		-- Visual mode: apply to the actual selection
		local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
		local function toggle_visual_linewise()
			-- leave Visual so '< and '> marks get fixed, then toggle using the visual mode type
			local vmode = vim.fn.visualmode()
			vim.api.nvim_feedkeys(esc, "nx", false)
			api.toggle.linewise(vmode)
		end

		vim.keymap.set("x", "<C-_>", toggle_visual_linewise, opts_x)
		vim.keymap.set("x", "<C-/>", toggle_visual_linewise, opts_x)
	end,
}
