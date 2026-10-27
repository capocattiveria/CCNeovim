return {
  -- Mostra un'intestazione "sticky" in cima alla finestra con il contesto
  -- corrente (funzione / classe / ciclo su cui si trova il cursore).
  'nvim-treesitter/nvim-treesitter-context',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    enable = true,
    max_lines = 3,        -- righe massime mostrate nell'intestazione
    min_window_height = 0,
    line_numbers = true,
    multiline_threshold = 1,
    trim_scope = 'outer',
    mode = 'cursor',      -- il contesto segue il cursore, non solo lo scroll
    separator = nil,
    zindex = 20,
  },
  config = function(_, opts)
    require('treesitter-context').setup(opts)

    -- Colore della linea di separazione sotto l'intestazione del contesto
    vim.api.nvim_set_hl(0, 'TreesitterContextBottomBorder', { link = 'Comment' })

    -- Salta all'inizio del contesto (utile per funzioni lunghe)
    vim.keymap.set('n', '[c', function()
      require('treesitter-context').go_to_context(vim.v.count1)
    end, { silent = true, desc = 'Salta al [c]ontesto (funzione) corrente' })
  end,
}
