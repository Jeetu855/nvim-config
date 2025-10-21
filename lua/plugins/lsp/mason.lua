-- lua/plugins/mason.lua (or wherever you keep it)
return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- safe requires
		local ok_mason, mason = pcall(require, "mason")
		local ok_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
		local ok_tool_installer, mason_tool_installer = pcall(require, "mason-tool-installer")

		if not ok_mason then
			-- nothing to do if mason itself isn't available
			return
		end

		-- Mason UI setup
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
				border = "rounded",
				width = 0.8,
				height = 0.8,
			},
		})

		-- Configure mason-lspconfig if available
		if ok_mason_lspconfig and mason_lspconfig then
			mason_lspconfig.setup({
				ensure_installed = {
					"lua_ls", -- Lua
					"pyright", -- Python
					"clangd", -- C / C++
					"jsonls", -- JSON
					"yamlls", -- YAML
				},

				-- keep mason installing servers if missing
				automatic_installation = true,

				-- IMPORTANT: disable automatic "legacy" auto-setup / auto-enable behavior so
				-- your own vim.lsp.config(...) + vim.lsp.enable(...) (in your lspconfig.lua) is used.
				automatic_enable = false,
			})

			-- NOTE: do not call setup_handlers({}) here to "neutralize" behavior.
			-- Recent mason-lspconfig versions provide automatic_enable / exclude options.
			-- Leaving setup_handlers manipulation out avoids relying on a deprecated flow.
		end

		-- mason-tool-installer (formatters / linters / utilities)
		if ok_tool_installer and mason_tool_installer then
			mason_tool_installer.setup({
				ensure_installed = {
					-- Formatters
					"prettier", -- JS, JSON, YAML, Markdown
					"stylua", -- Lua
					"isort", -- Python import sorter
					"black", -- Python formatter
					"clang-format", -- C/C++ formatter

					-- Linters
					"pylint", -- Python linter
					"eslint_d", -- JS linter
				},
				auto_update = false,
				run_on_start = true,
			})
		end
	end,
}
