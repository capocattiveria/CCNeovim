return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
  },
  config = function()
    local cmp = require 'cmp'
    
    -- Fix per caratteri speciali Assembly
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "asm", "s", "nasm" },
      callback = function()
        vim.opt_local.iskeyword:add(".")
        vim.opt_local.iskeyword:add("$")
      end,
    })

    cmp.setup {
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' }, -- Fondamentale per le .equ
        { name = 'path' },
      },
    }
  end,
}
