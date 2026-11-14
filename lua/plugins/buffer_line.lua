-- Bufferline: tab dei buffer in alto.
-- Obiettivo: non rompere mai il layout delle finestre (neo-tree, split, diffview...).
-- Per questo ogni chiusura di buffer passa da bufdelete, che sostituisce il buffer
-- nella finestra invece di chiuderla.

-- Chiude il buffer `n` senza toccare le finestre.
local function close_buffer(n)
  require("bufdelete").bufdelete(n, false)
end

-- Mostra in bufferline solo i buffer "normali" (file veri):
-- niente terminali, quickfix, help, scratch (buftype=nofile), pannelli di plugin.
local function only_real_buffers(buf)
  return vim.bo[buf].buftype == ""
end

return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    event = "VeryLazy",
    dependencies = { 'nvim-tree/nvim-web-devicons', 'famiu/bufdelete.nvim' },
    config = function()
      require("bufferline").setup {
        options = {
          numbers = "ordinal",
          separator_style = "thin",
          custom_filter = only_real_buffers,

          -- Chiusura sicura per il layout (X, click centrale, click destro)
          close_command = close_buffer,
          right_mouse_command = close_buffer,
          middle_mouse_command = close_buffer,

          offsets = {
            { filetype = "neo-tree", text = "File Explorer", text_align = "left", separator = true },
            { filetype = "DiffviewFiles", text = "Diff", text_align = "left", separator = true },
          },

          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = false,       -- niente "X" globale in alto a destra
          show_tab_indicators = true,
          always_show_bufferline = true,
          persist_buffer_sort = true,
          enforce_regular_tabs = false,
          truncate_names = true,
          max_name_length = 24,

          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,

          show_duplicate_prefix = true,
          duplicates_across_groups = true,
        },
      }

      local map = vim.keymap.set

      -- Navigazione
      map("n", "<leader>bp", "<cmd>BufferLinePick<CR>", { desc = "[B]uffer: scegli con lettera" })

      -- Riordino
      map("n", "<leader>b>", "<cmd>BufferLineMoveNext<CR>", { desc = "[B]uffer: sposta a destra" })
      map("n", "<leader>b<", "<cmd>BufferLineMovePrev<CR>", { desc = "[B]uffer: sposta a sinistra" })

      -- Pin (il buffer fissato resta a sinistra e non viene chiuso da "chiudi altri")
      map("n", "<leader>bt", "<cmd>BufferLineTogglePin<CR>", { desc = "[B]uffer: fissa/stacca" })

      -- Chiusure, tutte via bufdelete (layout intatto)
      map("n", "<leader>bo", function()
        local cur = vim.api.nvim_get_current_buf()
        for _, b in ipairs(vim.api.nvim_list_bufs()) do
          if b ~= cur and vim.bo[b].buflisted and vim.bo[b].buftype == ""
            and not vim.bo[b].modified then
            close_buffer(b)
          end
        end
      end, { desc = "[B]uffer: chiudi gli altri (non modificati)" })
      map("n", "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", { desc = "[B]uffer: chiudi a sinistra" })
      map("n", "<leader>bl", "<cmd>BufferLineCloseRight<CR>", { desc = "[B]uffer: chiudi a destra" })

      -- Navigazione (<S-l>, <S-h>, <leader>1..9): inerte nelle finestre "speciali"
      -- (neo-tree, terminale, diffview, quickfix) per non caricare un file al loro posto.
      local special_ft = { ["neo-tree"] = true, DiffviewFiles = true, qf = true }
      local function is_special(win)
        local b = vim.api.nvim_win_get_buf(win)
        return vim.bo[b].buftype == "terminal" or special_ft[vim.bo[b].filetype]
      end
      for _, lhs in ipairs { "<S-l>", "<S-h>" } do
        map("n", lhs, function()
          if is_special(0) then return end   -- inerte nelle finestre speciali
          vim.cmd(lhs == "<S-l>" and "BufferLineCycleNext" or "BufferLineCyclePrev")
        end, { desc = lhs == "<S-l>" and "Buffer successivo" or "Buffer precedente" })
      end
      for i = 1, 9 do
        map("n", "<leader>" .. i, function()
          if is_special(0) then return end
          vim.cmd("BufferLineGoToBuffer " .. i)
        end, { desc = "Vai al buffer " .. i })
      end

      -- I terminali non sono mai nella lista dei buffer
      vim.api.nvim_create_autocmd("TermOpen", {
        group = vim.api.nvim_create_augroup("bufferline_unlist_terminals", { clear = true }),
        callback = function(args) vim.bo[args.buf].buflisted = false end,
      })
    end,
  },
}
