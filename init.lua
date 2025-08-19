--[[

=====================================================================
=================== A BETTER WORLD WITH BETTER WORD =================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   CAPOCATTIVERIA   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:wq                 ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

--]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true

vim.opt.wrap = false

vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- clipboard
-- vim.schedule(function()
  -- vim.opt.clipboard = 'unnamedplus'
-- end)


-- Enable break indent
vim.opt.breakindent = true

vim.opt.undofile = true

--[[
    Case-insensitive searching UNLESS \C or one or more capital letters in
    the search term
--]]
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = "100"

-- Decrease update time
vim.opt.updatetime = 150

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 150

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10


vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Only use the system clipboard with leader, otherwise Ubuntu slow down the yanking system.
vim.keymap.set("n", "<leader>y", '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set("v", "<leader>y", '"+y', { desc = 'Copy highlighted to system clipboard' })
-- Paste from system clipboard with <leader>p
vim.keymap.set("n", "<leader>p", '"+p', { desc = 'Paste text from system clipboard' })
vim.keymap.set("v", "<leader>p", '"+p', { desc = 'Replace text with the system clipboard' })

vim.keymap.set("n", "//", ":nohlsearch<CR>", 
               { desc = 'Clear the highlight', noremap = true, silent = true })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
--
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   desc = 'Highlight when yanking (copying) text',
--   group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
--   callback = function()
--     vim.highlight.on_yank()
--   end,
-- })

-- ======================================================================================================

-- All Plugin are inside the lua/plug
require("plugins_setup")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- Make invisible characters visible
--vim.opt.listchars = { tab = '»·', trail = 'x', extends = '>', precedes = '<', space = '·', eol = '↲' }
--vim.api.nvim_set_keymap('n', '<leader>i', ':lua vim.opt.list = not vim.opt.list:get()<CR>', { desc = 'Toggle [I]nvisible Characters', silent = true })


function CloseBufferLineKeepPrevious()
  local current = vim.api.nvim_get_current_buf()
  local buffers = vim.fn.getbufinfo({buflisted = 1})

  -- Filter out Neotree buffer(s)
  local valid_buffers = {}
  for _, b in ipairs(buffers) do
    if not vim.api.nvim_buf_get_name(b.bufnr):match("NvimTree_") then
      table.insert(valid_buffers, b.bufnr)
    end
  end

  if #valid_buffers <= 1 then
    -- Last buffer, exit Neovim
    vim.cmd("qa")
  else
    -- Switch to previous buffer in bufferline
    local prev_buf = vim.fn.bufnr("#")
    if prev_buf <= 0 or vim.api.nvim_buf_get_name(prev_buf):match("NvimTree_") then
      -- fallback: pick the first buffer that's not current or Neotree
      for _, b in ipairs(valid_buffers) do
        if b ~= current then
          prev_buf = b
          break
        end
      end
    end

    -- Switch to previous buffer
    vim.cmd("buffer " .. prev_buf)
    -- Delete current buffer
    vim.cmd("bdelete " .. current)
  end
end
--
-- Map it to <leader>q
vim.keymap.set("n", "<leader>q", CloseBufferLineKeepPrevious, { noremap = true, silent = true })


