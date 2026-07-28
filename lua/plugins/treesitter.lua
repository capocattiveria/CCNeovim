return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',

  opts = {
    ensure_installed = {
	  'bash', 'c', 'cpp', 'diff', 'html', 'lua', 'luadoc',
	  'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc',
	  'sql', 'python', 'json', 'yaml', 'toml',
	  'dockerfile', 'gitcommit', 'gitignore', 'regex',
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
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "asm" },
      callback = function()
        vim.api.nvim_set_hl(0, "@comment.asm", { link = "Comment" })
      end
    })
  end,
}
