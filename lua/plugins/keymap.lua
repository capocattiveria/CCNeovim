local keymaps = {}

function keymaps.setup()
  -- Modalità inserimento: mappa 'jk' per uscire in modalità normale
  vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })

  -- Modalità normale: esempio di mappa per salvare velocemente
  vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = false, desc = 'Save buffer' })

  -- Modalità normale: esempio di mappa per chiudere la finestra
  vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = false, desc = 'Quit' })

end

return keymaps
