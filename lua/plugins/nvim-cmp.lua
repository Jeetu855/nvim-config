-- -- plugins/nvim-cmp.lua
-- return {
-- 	"hrsh7th/nvim-cmp",
-- 	event = "InsertEnter",
-- 	dependencies = {
-- 		"hrsh7th/cmp-buffer",
-- 		"hrsh7th/cmp-path",
-- 		"hrsh7th/cmp-nvim-lsp",
-- 		{
-- 			"L3MON4D3/LuaSnip",
-- 			version = "v2.*",
-- 			build = "make install_jsregexp", -- optional
-- 		},
-- 		"saadparwaiz1/cmp_luasnip",
-- 		"rafamadriz/friendly-snippets",
-- 		"onsails/lspkind.nvim",
-- 	},
-- 	config = function()
-- 		-- ===== REQUIRE MODULES SAFELY =====
-- 		local cmp_ok, cmp = pcall(require, "cmp")
-- 		if not cmp_ok then
-- 			return
-- 		end
--
-- 		local luasnip_ok, luasnip = pcall(require, "luasnip")
-- 		if not luasnip_ok then
-- 			luasnip = nil
-- 		end
--
-- 		local lspkind_ok, lspkind = pcall(require, "lspkind")
-- 		if not lspkind_ok then
-- 			lspkind = nil
-- 		end
--
-- 		-- ===== LOAD SNIPPETS =====
-- 		if luasnip then
-- 			require("luasnip.loaders.from_vscode").lazy_load()
-- 		end
--
-- 		-- ===== Helper: smart jump out of for(...) in C/C++ =====
-- 		local function jump_out_of_for_parens()
-- 			local ft = vim.bo.filetype
-- 			if ft ~= "c" and ft ~= "cpp" then
-- 				return false
-- 			end
--
-- 			local row, col = unpack(vim.api.nvim_win_get_cursor(0)) -- col is 0-based
-- 			local line = vim.api.nvim_get_current_line()
-- 			if not line:match("for%s*%(") then
-- 				return false
-- 			end
--
-- 			-- find the '(' after 'for'
-- 			local for_start = line:find("for%s*%(")
-- 			if not for_start then
-- 				return false
-- 			end
-- 			local paren_start = line:find("%(", for_start)
-- 			if not paren_start then
-- 				return false
-- 			end
--
-- 			-- find matching ')' for that '(' using a simple depth counter
-- 			local depth = 0
-- 			local match_idx = nil
-- 			for i = paren_start, #line do
-- 				local ch = line:sub(i, i)
-- 				if ch == "(" then
-- 					depth = depth + 1
-- 				elseif ch == ")" then
-- 					depth = depth - 1
-- 					if depth == 0 then
-- 						match_idx = i
-- 						break
-- 					end
-- 				end
-- 			end
--
-- 			if not match_idx then
-- 				return false
-- 			end
--
-- 			-- col is 0-based, string index is 1-based
-- 			-- position of ')' is (match_idx - 1)
-- 			-- we want to move cursor *after* ')', so col = match_idx
-- 			local paren_col_after = match_idx
--
-- 			-- If cursor is already after the ')', don't do anything
-- 			if col >= paren_col_after then
-- 				return false
-- 			end
--
-- 			-- Move cursor after ')'
-- 			vim.api.nvim_win_set_cursor(0, { row, paren_col_after })
-- 			return true
-- 		end
--
-- 		-- ===== MAIN CMP SETUP =====
-- 		cmp.setup({
-- 			window = {
-- 				completion = { scrollbar = false },
-- 				documentation = { scrollbar = false },
-- 			},
--
-- 			completion = {
-- 				completeopt = "menu,menuone,preview",
-- 			},
--
-- 			snippet = {
-- 				expand = function(args)
-- 					if luasnip then
-- 						luasnip.lsp_expand(args.body)
-- 					end
-- 				end,
-- 			},
--
-- 			-- ===== KEYMAPS (INCL. <Tab> / <S-Tab>) =====
-- 			mapping = cmp.mapping.preset.insert({
-- 				["<C-k>"] = cmp.mapping.select_prev_item(),
-- 				["<C-j>"] = cmp.mapping.select_next_item(),
-- 				["<C-Space>"] = cmp.mapping.complete(),
-- 				["<CR>"] = cmp.mapping.confirm({ select = false }),
--
-- 				-- TAB: completion -> snippet -> for(...) jump -> fallback (tabout / normal Tab)
-- 				["<Tab>"] = cmp.mapping(function(fallback)
-- 					if cmp.visible() then
-- 						cmp.select_next_item()
-- 					elseif luasnip and luasnip.expand_or_jumpable() then
-- 						luasnip.expand_or_jump()
-- 					elseif jump_out_of_for_parens() then
-- 						-- we handled it (jumped out of for(...)), do nothing more
-- 						return
-- 					else
-- 						-- Here we let Neovim fall back to the normal <Tab> mapping,
-- 						-- which is now owned by tabout.nvim.
-- 						fallback()
-- 					end
-- 				end, { "i", "s" }),
--
-- 				["<S-Tab>"] = cmp.mapping(function(fallback)
-- 					if cmp.visible() then
-- 						cmp.select_prev_item()
-- 					elseif luasnip and luasnip.jumpable(-1) then
-- 						luasnip.jump(-1)
-- 					else
-- 						fallback() -- tabout backwards / normal Shift-Tab
-- 					end
-- 				end, { "i", "s" }),
-- 			}),
--
-- 			-- ===== SOURCES =====
-- 			sources = cmp.config.sources({
-- 				{ name = "nvim_lsp" },
-- 				{ name = "luasnip" },
-- 				{ name = "buffer" },
-- 				{ name = "path" },
-- 			}),
--
-- 			-- ===== FORMATTING =====
-- 			formatting = {
-- 				format = (lspkind and lspkind.cmp_format({
-- 					maxwidth = 50,
-- 					ellipsis_char = "...",
-- 				})) or nil,
-- 			},
-- 		})
-- 	end,
-- }
--
--

-- plugins/nvim-cmp.lua
return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp", -- optional
		},
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
	},
	config = function()
		-- ===== REQUIRE MODULES SAFELY =====
		local cmp_ok, cmp = pcall(require, "cmp")
		if not cmp_ok then
			return
		end

		local luasnip_ok, luasnip = pcall(require, "luasnip")
		if not luasnip_ok then
			luasnip = nil
		end

		local lspkind_ok, lspkind = pcall(require, "lspkind")
		if not lspkind_ok then
			lspkind = nil
		end

		-- ===== LOAD SNIPPETS =====
		if luasnip then
			require("luasnip.loaders.from_vscode").lazy_load()
		end

		-- ===== Helper: smart jump out of for(...) in C/C++ =====
		local function jump_out_of_for_parens()
			local ft = vim.bo.filetype
			if ft ~= "c" and ft ~= "cpp" then
				return false
			end

			local row, col = unpack(vim.api.nvim_win_get_cursor(0)) -- col is 0-based
			local line = vim.api.nvim_get_current_line()
			if not line:match("for%s*%(") then
				return false
			end

			-- find the '(' after 'for'
			local for_start = line:find("for%s*%(")
			if not for_start then
				return false
			end
			local paren_start = line:find("%(", for_start)
			if not paren_start then
				return false
			end

			-- find matching ')' for that '(' using a simple depth counter
			local depth = 0
			local match_idx = nil
			for i = paren_start, #line do
				local ch = line:sub(i, i)
				if ch == "(" then
					depth = depth + 1
				elseif ch == ")" then
					depth = depth - 1
					if depth == 0 then
						match_idx = i
						break
					end
				end
			end

			if not match_idx then
				return false
			end

			-- col is 0-based, string index is 1-based
			-- position of ')' is (match_idx - 1)
			-- we want to move cursor *after* ')', so col = match_idx
			local paren_col_after = match_idx

			-- If cursor is already after the ')', don't do anything
			if col >= paren_col_after then
				return false
			end

			-- Move cursor after ')'
			vim.api.nvim_win_set_cursor(0, { row, paren_col_after })
			return true
		end

		-- ===== MAIN CMP SETUP =====
		cmp.setup({
			window = {
				completion = { scrollbar = false },
				documentation = { scrollbar = false },
			},

			completion = {
				completeopt = "menu,menuone,preview",
			},

			snippet = {
				expand = function(args)
					if luasnip then
						luasnip.lsp_expand(args.body)
					end
				end,
			},

			-- ===== KEYMAPS (TAB REMOVED; TABOUT OWNS <Tab>) =====
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),

			-- ===== SOURCES =====
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),

			-- ===== FORMATTING =====
			formatting = {
				format = (lspkind and lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				})) or nil,
			},
		})
	end,
}
