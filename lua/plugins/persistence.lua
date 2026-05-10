return

	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- si attiva all'apertura di un file
		opts = { options = { "buffers", "curdir", "tabpages", "winsize" } }
  	}
