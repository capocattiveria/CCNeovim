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

    require("persistence").setup(opts)

	if vim.fn.argc() == 0 then
      require("persistence").load()
      vim.schedule(function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.bo[buf].filetype ~= "neo-tree" and vim.api.nvim_buf_is_loaded(buf) then
            vim.api.nvim_buf_call(buf, function()
              vim.cmd("silent! e")
            end)
          end
        end
      end)
    end



  end,
}
