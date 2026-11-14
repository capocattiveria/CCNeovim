-- Git: gitsigns (hunk, blame, diff) + picker git di Telescope (branch, commit, status, stash)
local function tb(name, opts)
	return function() require('telescope.builtin')[name](opts or {}) end
end

return {
{
	'sindrets/diffview.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory', 'DiffviewToggleFiles' },
	opts = {},
	keys = {
		{ '<leader>gd', '<cmd>DiffviewOpen<cr>',          desc = 'Diff repo (working tree)' },
		{ '<leader>gD', '<cmd>DiffviewOpen HEAD~1<cr>',   desc = 'Diff vs commit precedente' },
		{ '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Storia del file' },
		{ '<leader>gH', '<cmd>DiffviewFileHistory<cr>',   desc = 'Storia del repo' },
		{ '<leader>gq', '<cmd>DiffviewClose<cr>',         desc = 'Chiudi diffview' },
	},
},
{
	'lewis6991/gitsigns.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = { 'nvim-telescope/telescope.nvim' },
	opts = {
		signs = {
			add = { text = '+' },
			change = { text = '~' },
			delete = { text = '_' },
			topdelete = { text = '‾' },
			changedelete = { text = '~' },
		},
		current_line_blame = false,
		on_attach = function(bufnr)
			local gs = require 'gitsigns'
			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
			end

			-- Navigazione tra hunk
			map('n', ']c', function()
				if vim.wo.diff then vim.cmd.normal { ']c', bang = true } else gs.nav_hunk 'next' end
			end, 'Hunk successivo')
			map('n', '[c', function()
				if vim.wo.diff then vim.cmd.normal { '[c', bang = true } else gs.nav_hunk 'prev' end
			end, 'Hunk precedente')

			-- Azioni sugli hunk (<leader>h = Git [H]unk)
			map('n', '<leader>hs', gs.stage_hunk, 'Stage hunk')
			map('n', '<leader>hr', gs.reset_hunk, 'Reset hunk')
			map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'Stage hunk')
			map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'Reset hunk')
			map('n', '<leader>hS', gs.stage_buffer, 'Stage buffer')
			map('n', '<leader>hR', gs.reset_buffer, 'Reset buffer')
			map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo stage hunk')
			map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')
			map('n', '<leader>hi', gs.preview_hunk_inline, 'Hunk inline (nel buffer)')
			map('n', '<leader>tl', function()
				gs.toggle_linehl(); gs.toggle_deleted(); gs.toggle_word_diff()
			end, '[T]oggle diff inline (tutto il file)')
			map('n', '<leader>hb', function() gs.blame_line { full = true } end, 'Blame riga')
			map('n', '<leader>hd', gs.diffthis, 'Diff vs indice')
			map('n', '<leader>hD', function() gs.diffthis '~' end, 'Diff vs ultimo commit')
			map('n', '<leader>tb', gs.toggle_current_line_blame, '[T]oggle blame riga')
			map('n', '<leader>tD', gs.toggle_deleted, '[T]oggle righe eliminate')

			-- Hunk come text object
			map({ 'o', 'x' }, 'ih', gs.select_hunk, 'Seleziona hunk')
		end,
	},
	keys = {
		{ '<leader>gb', tb 'git_branches',                         desc = 'Branch (checkout)' },
		{ '<leader>gc', tb 'git_commits',                          desc = 'Commit del repo' },
		{ '<leader>gC', tb 'git_bcommits',                         desc = 'Commit del file corrente' },
		{ '<leader>gs', tb 'git_status',                           desc = 'Status (file modificati)' },
		{ '<leader>gS', tb 'git_stash',                            desc = 'Stash' },
		{ '<leader>gf', tb 'git_files',                            desc = 'File tracciati' },
		{ '<leader>gu', function()
			local out = vim.fn.systemlist { 'git', 'diff', 'HEAD' }
			if #out == 0 then return vim.notify('Nessuna modifica', vim.log.levels.INFO) end
			vim.cmd 'enew'
			vim.api.nvim_buf_set_lines(0, 0, -1, false, out)
			vim.bo.filetype, vim.bo.buftype, vim.bo.bufhidden, vim.bo.modifiable = 'diff', 'nofile', 'wipe', false
			vim.keymap.set('n', 'q', '<cmd>bd<cr>', { buffer = true })
		end, desc = 'Diff unificato (un buffer)' },
		{ '<leader>gl', '<cmd>!git pull<cr>',                      desc = 'Pull' },
		{ '<leader>gp', '<cmd>!git push<cr>',                      desc = 'Push' },
	},
},
}
