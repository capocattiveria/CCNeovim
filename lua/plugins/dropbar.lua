return {
  -- Winbar con "briciole di pane": file › classe › funzione › blocco.
  -- Usa LSP quando disponibile, altrimenti fa fallback su treesitter.
  -- I componenti sono cliccabili (col mouse) e navigabili da tastiera.
  'Bekaboo/dropbar.nvim',
  -- telescope-fzf-native (già installato con telescope) abilita la ricerca
  -- fuzzy nel menu interattivo delle briciole di pane.
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    local dropbar = require('dropbar')

    dropbar.setup {
      bar = {
        -- Nascondi la winbar nei buffer speciali (neo-tree, terminali, ecc.)
        enable = function(buf, win, _)
          if
            not vim.api.nvim_buf_is_valid(buf)
            or not vim.api.nvim_win_is_valid(win)
            or vim.fn.win_gettype(win) ~= ''
            or vim.wo[win].winbar ~= ''
            or vim.bo[buf].buftype ~= ''
          then
            return false
          end
          return vim.bo[buf].filetype ~= 'neo-tree'
        end,
      },
      icons = {
        --kinds = { use_devicons = vim.g.have_nerd_font },
      },
    }

    -- Apri il menu interattivo della briciola sotto il cursore
    vim.keymap.set('n', '<leader>;', function()
      require('dropbar.api').pick()
    end, { desc = 'Dropbar: seleziona componente (briciole di pane)' })
  end,
}
