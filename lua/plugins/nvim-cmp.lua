return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp", -- <<--- ADDED (required for nvim_lsp source)
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp", -- optional; remove if you don't want to run make
		},
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
	},
	config = function()
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

		-- load vscode-style snippets
		if luasnip then
			require("luasnip.loaders.from_vscode").lazy_load()
		end

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

			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),

			formatting = {
				format = (lspkind and lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				})) or nil,
			},
		})

		-- Optional: Tab behavior to navigate menu and expand/jump snippets
		-- Uncomment if you want Tab/Shift-Tab UX
		--[[
    cmp.setup({
      mapping = vim.tbl_extend("force", cmp.get_config().mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip and luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip and luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    })
    --]]
	end,
}
