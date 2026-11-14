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

  -- Ricarica dal disco tutti i file aperti nei buffer (salta quelli modificati)
  vim.keymap.set("n", "<leader>br", function()
	local current = vim.api.nvim_get_current_buf()
	local reloaded, skipped = 0, 0
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
	  if vim.api.nvim_buf_is_loaded(buf)
		and vim.bo[buf].buflisted
		and vim.bo[buf].buftype == ""
		and vim.api.nvim_buf_get_name(buf) ~= "" then
		if vim.bo[buf].modified then
		  skipped = skipped + 1
		else
		  vim.api.nvim_buf_call(buf, function()
			vim.cmd("edit!")
		  end)
		  reloaded = reloaded + 1
		end
	  end
	end
	vim.api.nvim_set_current_buf(current)
	local msg = ("Ricaricati %d buffer"):format(reloaded)
	if skipped > 0 then
	  msg = msg .. (" (%d saltati perché modificati)"):format(skipped)
	end
	vim.notify(msg, vim.log.levels.INFO)
  end, { desc = "Reload all open buffers from disk" })

end

return keymaps
