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
 	      separator_style = "slant", -- o "thick" | "thin" | "padded_slant"
 	      -- Integrazione con Neo-tree
 	      offsets = {
 		{
 		  filetype = "neo-tree",
 		  text = "File Explorer",
 		  text_align = "left",
		  separator = true
 		}
 	      },
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
      vim.keymap.set("n", "<leader>q", "<cmd>bdelete<CR>", { desc = "Close buffer" })

      -- Leader + numero → vai al buffer N
      for i = 1, 9 do
        vim.keymap.set("n", "<leader>" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<CR>",
          { desc = "Go to buffer " .. i })
      end
     end
  }
}



