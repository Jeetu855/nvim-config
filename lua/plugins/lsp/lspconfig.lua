-- lua/plugins/lsp/lspconfig.lua
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- Safe requires (optional modules)
		local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		local mason_ok, mason_lspconfig = pcall(require, "mason-lspconfig")

		-- Capabilities (for autocompletion)
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		if cmp_ok and cmp_nvim_lsp then
			capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
		end

		-- LSP keymaps on attach
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }
				local keymap = vim.keymap

				keymap.set("n", "gD", "<cmd>Telescope lsp_definitions<CR>", opts)
				keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
				keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				keymap.set("n", "<leader>srn", vim.lsp.buf.rename, opts)
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
				keymap.set("n", "g?", vim.lsp.buf.hover, opts)
			end,
		})

		-- Diagnostic configuration (new API)
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
			underline = true,
			update_in_insert = false,
			virtual_text = {
				spacing = 4,
				prefix = "●",
			},
			float = {
				border = "rounded",
				source = "always",
			},
		})
		-- Configure + enable server using native API when available.
		local function configure_server(server_name, opts)
			if not server_name or server_name == "" then
				return
			end
			opts = opts or {}

			-- Preferred: use new API (Neovim 0.11+)
			if vim.lsp and vim.lsp.config then
				local ok, _ = pcall(vim.lsp.config, server_name, opts)
				if ok then
					-- enable autostart for the server's filetypes/root_dir
					pcall(vim.lsp.enable, server_name)
					return
				end
			end

			-- Fallback to legacy lspconfig if new API fails or not available
			local ok_lsp, lspconfig = pcall(require, "lspconfig")
			if ok_lsp and lspconfig and lspconfig[server_name] and type(lspconfig[server_name].setup) == "function" then
				vim.schedule(function()
					vim.notify(
						("lsp: falling back to require('lspconfig').%s.setup() (deprecated, but safe)"):format(
							server_name
						),
						vim.log.levels.WARN
					)
				end)
				pcall(lspconfig[server_name].setup, opts)
				return
			end

			-- If neither API available
			vim.schedule(function()
				vim.notify(
					("lsp: skipping server '%s' (no builtin config via vim.lsp.config or lspconfig)"):format(
						server_name
					),
					vim.log.levels.DEBUG
				)
			end)
		end

		-- Server-specific configs
		local servers = {
			pyright = {
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
							typeCheckingMode = "basic",
						},
					},
				},
			},

			clangd = {
				capabilities = capabilities,
			},

			lua_ls = {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						completion = { callSnippet = "Replace" },
					},
				},
			},

			svelte = {
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePost", {
						pattern = { "*.js", "*.ts" },
						callback = function(ctx)
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
						end,
					})
				end,
			},
		}

		-- Register with mason-lspconfig if present
		if mason_ok and mason_lspconfig and type(mason_lspconfig.setup_handlers) == "function" then
			local handlers = {}

			-- Default handler: use servers table default or fallback to capabilities
			handlers[1] = function(server_name)
				if not server_name or server_name == "" then
					return
				end
				local opts = servers[server_name] or { capabilities = capabilities }
				configure_server(server_name, opts)
			end

			-- Per-server handlers from your servers table
			for name, opt in pairs(servers) do
				handlers[name] = function()
					configure_server(name, opt)
				end
			end

			mason_lspconfig.setup_handlers(handlers)
		else
			-- Fallback: configure directly
			for name, opt in pairs(servers) do
				configure_server(name, opt)
			end
		end
	end,
}
