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
      -- Statusline con uno sfondo piu' chiaro cosi' non si confonde con l'editor.
      -- Per cambiare tonalita': surface0 (piu' scuro) -> surface1 -> surface2 (piu' chiaro).
      custom_highlights = function(colors)
        return {
          StatusLine = { fg = colors.text, bg = colors.surface1 },
          StatusLineNC = { fg = colors.overlay0, bg = colors.surface0 },
          MiniStatuslineDevinfo = { fg = colors.subtext1, bg = colors.surface1 },
          MiniStatuslineFileinfo = { fg = colors.subtext1, bg = colors.surface1 },
          MiniStatuslineFilename = { fg = colors.subtext0, bg = colors.surface1 },
          MiniStatuslineInactive = { fg = colors.blue, bg = colors.surface0 },
        }
      end,
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

      -- gruvbox e' un tema vimscript e non ha una palette Lua, quindi la
      -- statusline la personalizziamo a mano ogni volta che il tema viene
      -- (ri)applicato. Palette gruvbox dark:
      --   bg0 #282828 (sfondo editor) -> bg1 #3c3836 -> bg2 #504945 (piu' chiaro)
      --   fg1 #ebdbb2  fg4 #a89984  gray #928374
      local function set_gruvbox_statusline()
        local hl = vim.api.nvim_set_hl
        -- Palette blu/azzurro gruvbox: #458588 (blu) / #83a598 (azzurro chiaro).
        -- Finestra attiva: barra blu ben staccata dall'editor.
        hl(0, "StatusLine", { fg = "#ebdbb2", bg = "#458588" })
        hl(0, "MiniStatuslineDevinfo", { fg = "#ebdbb2", bg = "#458588" })
        hl(0, "MiniStatuslineFileinfo", { fg = "#ebdbb2", bg = "#458588" })
        hl(0, "MiniStatuslineFilename", { fg = "#d5c4a1", bg = "#458588" })
        -- Finestra inattiva: blu spento ma barra comunque piena, cosi' con gli
        -- split orizzontali la separazione si vede sempre.
        hl(0, "StatusLineNC", { fg = "#d5c4a1", bg = "#345658" })
        hl(0, "MiniStatuslineInactive", { fg = "#d5c4a1", bg = "#345658" })
        -- Separatore verticale (e orizzontale) tra finestre: linea azzurra marcata.
        hl(0, "WinSeparator", { fg = "#83a598", bg = "#282828", bold = true })
        hl(0, "VertSplit", { fg = "#83a598", bg = "#282828", bold = true })
      end

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "gruvbox",
        group = vim.api.nvim_create_augroup("GruvboxStatusline", { clear = true }),
        callback = set_gruvbox_statusline,
      })

      -- Se gruvbox e' gia' attivo al momento del load, applica subito.
      if vim.g.colors_name == "gruvbox" then
        set_gruvbox_statusline()
      end
    end,
  }
}
