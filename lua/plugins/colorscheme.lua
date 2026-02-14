return {
 {
  --Colorschemes: `:Telescope colorscheme`.
  'folke/tokyonight.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    --vim.cmd.colorscheme 'tokyonight-night'

    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
  end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- Puoi provare: latte, frappe, macchiato, mocha
      transparent_background = false,
      show_end_of_buffer = false, -- nasconde le ~ alla fine del file
      term_colors = true,
      integrations = {
        treesitter = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
        },
        telescope = { enabled = true },
        mason = true,
        nvimtree = true,
        indent_blankline = { enabled = true },
        gitsigns = true,
        notify = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  {
    "morhetz/gruvbox",
    lazy = false,
    priority = 1000,
    config = function()
      --vim.cmd("colorscheme gruvbox")
    end,
  }
}
