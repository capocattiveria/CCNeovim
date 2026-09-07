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

if vim.env.WT_SESSION then
  vim.opt.mouse = "a"
end

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"asm"},
  callback = function()
    -- Uniforma tutti i commenti allo stesso colore
    vim.api.nvim_set_hl(0, "@comment.asm", { link = "Comment" })
    vim.api.nvim_set_hl(0, "@comment.documentation.asm", { link = "Comment" })
  end
})

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
vim.opt.timeoutlen = 300

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

--[[
***********************************************************************
***************************** CUSTOM KEYMAP ***************************
***********************************************************************
--]]

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', 'jk', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Resizing window keymap
vim.keymap.set("n", "<A-h>", ":vertical resize -2<CR>", { desc = 'Decrease width'})
vim.keymap.set("n", "<A-l>", ":vertical resize +2<CR>", { desc = 'Increase width'})
vim.keymap.set("n", "<A-j>", ":resize -2<CR>", { desc = 'Decrease heigth'})
vim.keymap.set("n", "<A-k>", ":resize +2<CR>", { desc = 'Increase heigth'})

-- Only use the system clipboard with leader, otherwise Ubuntu slow down the yanking system.
vim.keymap.set("n", "<leader>y", '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set("v", "<leader>y", '"+y', { desc = 'Copy highlighted to system clipboard' })
-- Paste from system clipboard with <leader>p
vim.keymap.set("n", "<leader>p", '"+p', { desc = 'Paste text from system clipboard' })
vim.keymap.set("v", "<leader>p", '"+p', { desc = 'Replace text with the system clipboard' })

vim.keymap.set("n", "//", ":nohlsearch<CR>", 
               { desc = 'Clear the highlight', noremap = true, silent = true })

-- ======================================================================================================

-- All Plugin are inside the lua/plug
require("plugins_setup")

-- The line beneath this is called `modeline`. See `:help modeline`
-- ts=2 sts=2 sw=2 et
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

-- Make invisible characters visible
vim.opt.listchars = { tab = '»·', trail = 'x', extends = '>', precedes = '<', space = '·', eol = '↲' }

vim.opt.list = false

vim.api.nvim_set_keymap('n', '<leader>i', ':lua vim.opt.list = not vim.opt.list:get()<CR>', { desc = 'Toggle [I]nvisible Characters', silent = true })

--------------------------------------------------------------------------------------------------
-- C++ formatting
-- Indentazione 4 spazi solo per C++
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cpp", "hpp", "h" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 0
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = false
  end,
})

--------------------------------------------------------------------------------------------------
-- STYLE
vim.cmd([[colorscheme gruvbox]])

-- Definiamo due colori: uno per Normal e uno per Insert
vim.api.nvim_set_hl(0, 'MyCursor', 			{ fg = '#000000', 	bg = '#ff9e64' }) -- Arancione
vim.api.nvim_set_hl(0, 'MyInsertCursor', 	{ fg = '#1a1b26', 	bg = '#7aa2f7' }) -- Blu
vim.api.nvim_set_hl(0, 'Visual', 			{ fg = 'none' ,		bg = '#3b4261'} ) -- blue with transparent

vim.opt.guicursor = "n-v-c:block-MyCursor,i-ci-ve:ver25-MyInsertCursor,r-cr:hor20-MyCursor"

--------------------------------------------------------------------------------------------------

