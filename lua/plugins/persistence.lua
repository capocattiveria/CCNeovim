return {
  "folke/persistence.nvim",
  event = "VimEnter",
  opts = {},
  keys = {
    { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
  },
  config = function(_, opts)

    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        pcall(vim.cmd, "Neotree close")
      end,
    })


    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        pcall(vim.cmd, "Neotree close")
      end,
    })

    require("persistence").setup(opts)

	if vim.fn.argc() == 0 then
    	require("persistence").load()
    	vim.schedule(function()
      	vim.cmd("silent! bufdo e")
    	end)
  	end



  end,
}
