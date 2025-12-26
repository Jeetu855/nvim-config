-- return {
-- 	"abecodes/tabout.nvim",
-- 	event = "InsertEnter",
-- 	dependencies = { "nvim-treesitter", "hrsh7th/nvim-cmp" },
-- 	config = function()
-- 		require("tabout").setup({
-- 			tabkey = "<Tab>",
-- 			backwards_tabkey = "<S-Tab>",
-- 			act_as_tab = true,
-- 			act_as_shift_tab = false,
-- 			default_tab = "<C-t>",
-- 			default_shift_tab = "<C-d>",
-- 			enable_backwards = true,
-- 			completion = true,
-- 			tabouts = {
-- 				{ open = "'", close = "'" },
-- 				{ open = '"', close = '"' },
-- 				{ open = "`", close = "`" },
-- 				{ open = "(", close = ")" },
-- 				{ open = "[", close = "]" },
-- 				{ open = "{", close = "}" },
-- 				{ open = "<", close = ">" },
-- 			},
-- 			ignore_beginning = true,
-- 			exclude = {},
-- 		})
-- 	end,
-- }
--
--

-- plugins/tabout.lua
return {
	"abecodes/tabout.nvim",
	-- load it eagerly so mappings are always there
	lazy = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"L3MON4D3/LuaSnip",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		local ok, tabout = pcall(require, "tabout")
		if not ok then
			return
		end

		tabout.setup({
			-- tabout will create these mappings in INSERT mode
			tabkey = "<Tab>", -- key to trigger tabout
			backwards_tabkey = "<S-Tab>",

			act_as_tab = true, -- if no tabout possible, behave like a normal Tab
			act_as_shift_tab = false,
			default_tab = "<C-t>",
			default_shift_tab = "<C-d>",
			enable_backwards = true,

			-- IMPORTANT with nvim-cmp: let cmp handle completion, not tabout
			completion = false,

			tabouts = {
				{ open = "'", close = "'" },
				{ open = '"', close = '"' },
				{ open = "`", close = "`" },
				{ open = "(", close = ")" },
				{ open = "[", close = "]" },
				{ open = "{", close = "}" },
				{ open = "<", close = ">" },
			},

			ignore_beginning = true,
			exclude = {}, -- you can add filetypes here if needed
		})
	end,
}
