-- ~/.config/nvim/lua/lazy_setup.lua
-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Setup Lazy with your chosen plugins
require("lazy").setup({
	{ import = "plugins.autopairs" },
	{ import = "plugins.colorscheme" },
	{ import = "plugins.comment" },
	{ import = "plugins.formatting" },
	{ import = "plugins.lualine" },
	{ import = "plugins.mini-indentscope" },
	{ import = "plugins.nvim-cmp" },
	{ import = "plugins.tabout" },
	{ import = "plugins.telescope" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.lsp" },
	{ import = "plugins.nvim-tree" },
	{ import = "plugins.flash" },
	{ import = "plugins.flash" },
	{ import = "plugins.indent-blankline" },
	{ import = "plugins.dressing" },
	{ import = "plugins.nvim-surround" },
	{ import = "plugins.smear_cursor" },
	{ import = "plugins.code_runner" },
}, {
	checker = { enabled = true, notify = false },
	change_detection = { notify = false },
})
