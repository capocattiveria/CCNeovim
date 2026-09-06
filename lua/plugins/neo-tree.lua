-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
  },
	opts = {
		default_component_configs = {
			git_status = {
			  symbols = {
				unstaged = "✗",
				staged = "✓",
				modified = "●",
				renamed = "➜",
				untracked = "★",
				ignored = "◌",
				deleted = "✖",
				conflict = "",
			  },
			},
		  },
	  close_if_last_window = false,
	  window = {
		position = "float",
		width = 30,
	  },
	},
	config = function(_, opts)
	  require("neo-tree").setup(opts)

	  vim.api.nvim_create_autocmd("FileType", {
		pattern = "neo-tree",
		callback = function()
		  vim.wo.winfixwidth = true
		end,
	  })
	end,
}


-- return {
--   "nvim-neo-tree/neo-tree.nvim",
--   version = "*",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-tree/nvim-web-devicons",
--     "MunifTanjim/nui.nvim",
--   },
--   cmd = "Neotree",
--   keys = {
--     { "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
--   },
--   opts = {
-- 	close_if_last_windows = true,
-- 	window = {
-- 		position = "left",
-- 		width = 30,
-- 	},
--     filesystem = {
--       window = {
--         mappings = {
--           ["\\"] = "close_window",
--         },
--       },
--     },
--   },
--   config = function(_, opts)
--     require("neo-tree").setup(opts)
--
--     vim.api.nvim_create_autocmd("User", {
--       pattern = "PersistenceLoadPost",
--       callback = function()
--         vim.cmd("Neotree show")
--       end,
--     })
--   end,
-- }

