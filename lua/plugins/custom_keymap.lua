local keymaps = {}

function keymaps.setup()

  vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })

  -- Modalità normale: esempio di mappa per salvare velocemente
  vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = false, desc = 'Save buffer' })

  -- Manage the bufdelete to remove buffer without close the window and let neotree to
  -- get all the space
	vim.keymap.set("n", "<leader>q", function()
	  if vim.bo.buftype == "terminal" then
		require("bufdelete").bufdelete(0, true)  -- force, il processo terminal viene comunque terminato
	  else
		require("bufdelete").bufdelete(0, false)
	  end
	end, { desc = "Delete buffer (keep layout)" })

end

return keymaps
