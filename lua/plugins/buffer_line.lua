return {
     {
     'akinsho/bufferline.nvim',
     version = "*",
     dependencies = 'nvim-tree/nvim-web-devicons',
     config = function()
       require("bufferline").setup{
 	    options = {
 	      -- Numeri sui buffer
 	      numbers = "ordinal", -- o "ordinal" | "buffer_id" | "both"
 	      -- Separatori
 	      separator_style = "thin", -- "slant" | "thick" | "thin" | "padded_slant"
 	      -- Integrazione con Neo-tree
 	      offsets = {
 		{
 		  filetype = "neo-tree",
 		  text = "File Explorer",
 		  text_align = "left",
		  separator = true
 		}
 	      },
              -- Nasconde dalla bufferline tutti i buffer di tipo terminale
              -- (incluso quello di Claude Code). Ridondante con l'autocmd
              -- che li rende unlisted, ma copre anche eventuali casi limite.
              custom_filter = function(buf_number)
                return vim.bo[buf_number].buftype ~= "terminal"
              end,
 	      -- Mostra icone
 	      show_buffer_icons = true,
 	      show_buffer_close_icons = true,
 	      show_close_icon = true,
 	      -- Diagnostics integration
 	      diagnostics = "nvim_lsp",
 	      diagnostics_update_in_insert = false,
 	      -- Colori per i tab modificati
 	      show_duplicate_prefix = true,
 	      duplicates_across_groups = true,
 	    }
 	  }

      -- Keymap to 
      vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
      vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
      --vim.keymap.set("n", "<leader>q", "<cmd>bdelete<CR>", { desc = "Close buffer" })

      -- Leader + numero → vai al buffer N
       for i = 1, 9 do
         vim.keymap.set("n", "<leader>" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<CR>",
           { desc = "Go to buffer " .. i })
      end

      -- Tutti i terminali vengono tolti dall'elenco dei buffer
      -- (buflisted = false): cosi' non compaiono in bufferline e nessun
      -- comando di navigazione (<S-l>, <S-h>, :bnext, :bprev...) puo'
      -- caricarli nella finestra del codice.
      vim.api.nvim_create_autocmd("TermOpen", {
        group = vim.api.nvim_create_augroup("bufferline_unlist_terminals", { clear = true }),
        callback = function(args)
          vim.bo[args.buf].buflisted = false
        end,
      })

      -- Nelle finestre di tipo terminale disabilita lo scorrimento tra i buffer:
      -- override buffer-local che rende inerti i tasti di navigazione bufferline.
      vim.api.nvim_create_autocmd("TermOpen", {
        group = vim.api.nvim_create_augroup("bufferline_lock_in_terminal", { clear = true }),
        callback = function(args)
          local opts = { buffer = args.buf, nowait = true, desc = "Disabilitato nei terminali" }
          vim.keymap.set("n", "<S-l>", "<Nop>", opts)
          vim.keymap.set("n", "<S-h>", "<Nop>", opts)
          for i = 1, 9 do
            vim.keymap.set("n", "<leader>" .. i, "<Nop>", opts)
          end
        end,
      })
     end
  }
}



