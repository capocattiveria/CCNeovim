return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',

  opts = {
    ensure_installed = {
      'bash', 'c', 'diff', 'html', 'lua', 'luadoc',
      'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc'
    },

    auto_install = true,

    highlight = {
      enable = true,
      disable = { 'asm' },
      additional_vim_regex_highlighting = { 'ruby' },
    },

    indent = {
      enable = true,
      disable = { 'ruby' },
    },
  },
  --
  -- config = function(_, opts)
  --   require('nvim-treesitter.configs').setup(opts)
  --
  --   vim.api.nvim_create_autocmd("FileType", {
  --     pattern = { "asm" },
  --     callback = function()
  --       vim.api.nvim_set_hl(0, "@comment.asm", { link = "Comment" })
  --     end
  --   })
  -- end,
}
