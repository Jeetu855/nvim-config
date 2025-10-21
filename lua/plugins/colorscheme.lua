return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        background = { light = "latte", dark = "mocha" },
        integrations = {
          treesitter = true,
          cmp = true,
          telescope = true,
          nvimtree = true,
          which_key = true,
          native_lsp = true,
        },
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = true,
        dim_inactive = { enabled = false, shade = "dark", percentage = 0.15 },
        styles = {
          comments = { "italic" },
          functions = { "bold" },
          types = { "bold" },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}

