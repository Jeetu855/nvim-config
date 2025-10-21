-- ~/.config/nvim/lua/plugins/init.lua

-- Simple helper to safely require plugin modules
local function safe_require(name)
	local ok, mod = pcall(require, name)
	if not ok then
		vim.schedule(function()
			vim.notify(("Failed to load %s: %s"):format(name, mod), vim.log.levels.ERROR)
		end)
		return nil
	end
	return mod
end

-- Base plugins
local plugins = {
	"nvim-lua/plenary.nvim", -- Utility library used by many plugins
	"christoomey/vim-tmux-navigator", -- Navigate seamlessly between vim and tmux panes
}

-- Add nvim-tree if available
local nvim_tree = safe_require("plugins.nvim-tree")
if type(nvim_tree) == "table" then
	table.insert(plugins, nvim_tree)
end

return plugins
