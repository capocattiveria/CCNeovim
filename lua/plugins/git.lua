return {
	'wsdjeg/git.nvim',
	dependencies = {
		'wsdjeg/job.nvim',       -- Required
		'wsdjeg/notify.nvim',    -- Recommended
	},
	cmd = 'Git',
	keys =
	{
		-- Stato / staging
		{ '<leader>gs', '<cmd>Git status<cr>',        desc = 'Git status' },
		{ '<leader>ga', '<cmd>Git add %<cr>',         desc = 'Git add (file corrente)' },
		{ '<leader>gA', '<cmd>Git add .<cr>',         desc = 'Git add tutto' },

		-- Commit
		{ '<leader>gc', '<cmd>Git commit<cr>',        desc = 'Git commit' },

		-- Log / diff / blame
		{ '<leader>gv', '<cmd>Git log<cr>',           desc = 'Git log' },
		{ '<leader>gV', '<cmd>Git log %<cr>',         desc = 'Git log (file corrente)' },
		{ '<leader>gd', '<cmd>Git diff<cr>',          desc = 'Git diff' },
		{ '<leader>gB', '<cmd>Git blame<cr>',         desc = 'Git blame' },

		-- Remoto
		{ '<leader>gp', '<cmd>Git push<cr>',          desc = 'Git push' },
		{ '<leader>gP', '<cmd>Git pull<cr>',          desc = 'Git pull' },
		{ '<leader>gf', '<cmd>Git fetch<cr>',         desc = 'Git fetch' },
		{ '<leader>gR', '<cmd>Git remote<cr>',        desc = 'Remote browser' },

		-- Branch / stash
		{ '<leader>gS', '<cmd>Git stash<cr>',         desc = 'Git stash' },
		{ '<leader>gm', '<cmd>Git branch<cr>',        desc = 'Branch manager' },

		-- Picker (richiede picker.nvim)
		{ '<leader>gb', '<cmd>Picker git-branch<cr>', desc = 'Cambia branch (picker)' },
		{ '<leader>gG', '<cmd>Picker git-ghosts<cr>', desc = 'File eliminati (picker)' },
		},
		config = function()
			-- Optional configuration
		end,
}
