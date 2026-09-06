return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
  },
  config = function()
    require("claude-code").setup({
      -- Terminal window settings
      window = {
        split_ratio = 0.3,      -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
        position = "botright",  -- Position of the window: "botright", "topleft", "vertical", "float", etc.
        enter_insert = true,    -- Whether to enter insert mode when opening Claude Code
        hide_numbers = true,    -- Hide line numbers in the terminal window
        hide_signcolumn = true, -- Hide the sign column in the terminal window

        -- Floating window configuration (only applies when position = "float")
        float = {
          width = "80%",        -- Width: number of columns or percentage string
          height = "80%",       -- Height: number of rows or percentage string
          row = "center",       -- Row position: number, "center", or percentage string
          col = "center",       -- Column position: number, "center", or percentage string
          relative = "editor",  -- Relative to: "editor" or "cursor"
          border = "rounded",   -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
        },
      },
      -- File refresh settings
      refresh = {
        enable = true,           -- Enable file change detection
        updatetime = 100,        -- updatetime when Claude Code is active (milliseconds)
        timer_interval = 1000,   -- How often to check for file changes (milliseconds)
        show_notifications = true, -- Show notification when files are reloaded
      },
      -- Git project settings
      git = {
        use_git_root = true,     -- Set CWD to git root when opening Claude Code (if in git project)
      },
      -- Shell-specific settings
      shell = {
        separator = '&&',        -- Command separator used in shell commands
        pushd_cmd = 'pushd',     -- Command to push directory onto stack (e.g., 'pushd' for bash/zsh, 'enter' for nushell)
        popd_cmd = 'popd',       -- Command to pop directory from stack (e.g., 'popd' for bash/zsh, 'exit' for nushell)
      },
      -- Command settings
      command = "claude",        -- Command used to launch Claude Code
      -- Command variants
      command_variants = {
        -- Conversation management
        continue = "--continue", -- Resume the most recent conversation
        resume = "--resume",     -- Display an interactive conversation picker

        -- Output options
        verbose = "--verbose",   -- Enable verbose logging with full turn-by-turn output
      },
      -- Keymaps
      --
      -- Tutte le keymap automatiche del plugin sono disabilitate qui sotto per
      -- evitare che facciano l'override delle remap personali:
      --   * window_navigation rimappa <C-h/j/k/l> nel buffer del terminale Claude
      --   * scrolling rimappa <C-f>/<C-b> nel buffer del terminale Claude
      --   * toggle/variants registrano keymap globali (<C-,>, <leader>cC, <leader>cV)
      -- Le keymap che vogliamo davvero le impostiamo a mano piu' sotto, e solo se
      -- il tasto non e' gia' occupato.
      keymaps = {
        toggle = {
          normal = false,
          terminal = false,
          variants = {
            continue = false,
            verbose = false,
          },
        },
        window_navigation = false, -- Non toccare <C-h/j/k/l>
        scrolling = false,         -- Non toccare <C-f>/<C-b>
      },
    })

    -- Imposta una keymap solo se non e' gia' definita (globalmente), cosi' non
    -- sovrascriviamo mai una remap esistente.
    local function map_if_free(mode, lhs, rhs, opts)
      if vim.fn.maparg(lhs, mode) ~= "" then
        vim.notify(
          ("claude-code: keymap %s (%s) gia' in uso, non la sovrascrivo"):format(lhs, mode),
          vim.log.levels.WARN
        )
        return
      end
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    map_if_free("n", "<leader>cl", "<cmd>ClaudeCode<CR>", { desc = "Claude Code: Toggle" })
    map_if_free("t", "<C-,>", [[<C-\><C-n>:ClaudeCode<CR>]], { desc = "Claude Code: Toggle" })
    map_if_free("n", "<leader>cL", "<cmd>ClaudeCodeContinue<CR>", { desc = "Claude Code: Continue" })
  end,
}
