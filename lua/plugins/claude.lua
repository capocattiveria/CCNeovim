return {
  -- Integrazione "vera" di Claude Code: implementa lo stesso protocollo delle
  -- estensioni IDE ufficiali, quindi puoi selezionare del codice in visual mode
  -- e inviarlo a Claude con :ClaudeCodeSend (<leader>cs).
  "coder/claudecode.nvim",
  -- 'folke/snacks.nvim' e' opzionale: serve solo per il provider di terminale
  -- "snacks". Qui usiamo il terminale nativo di Neovim, nessuna dipendenza extra.
  dependencies = { "nvim-lua/plenary.nvim" },

  -- Carica il plugin solo quando serve davvero (comando o keymap).
  cmd = {
    "ClaudeCode",
    "ClaudeCodeFocus",
    "ClaudeCodeSend",
    "ClaudeCodeAdd",
    "ClaudeCodeTreeAdd",
    "ClaudeCodeStatus",
    "ClaudeCodeStart",
    "ClaudeCodeStop",
    "ClaudeCodeSelectModel",
    "ClaudeCodeDiffAccept",
    "ClaudeCodeDiffDeny",
  },

  keys = {
    { "<leader>cl", "<cmd>ClaudeCode<cr>", desc = "Claude Code: Toggle" },
    { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Claude Code: Focus" },
    { "<leader>cL", "<cmd>ClaudeCode --continue<cr>", desc = "Claude Code: Continue" },
    { "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Claude Code: Resume (picker)" },
    { "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Claude Code: Seleziona modello" },

    -- Stesso toggle di greggh/claude-code.nvim, in normale e in terminale.
    { "<C-,>", "<cmd>ClaudeCode<cr>", mode = { "n", "t" }, desc = "Claude Code: Toggle" },

    -- >>> La feature che volevi: seleziona il codice (v / V) e invialo a Claude.
    { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Claude Code: Invia selezione" },

    -- Aggiunge il buffer corrente al contesto (senza selezione).
    { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Claude Code: Aggiungi buffer corrente" },

    -- Dentro neo-tree: <leader>cs aggiunge il file/cartella sotto il cursore.
    {
      "<leader>cs",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      ft = { "neo-tree", "NvimTree", "oil", "minifiles" },
      desc = "Claude Code: Aggiungi file dall'albero",
    },

    -- Gestione dei diff che Claude apre quando modifica i file.
    -- (<leader>ca e' gia' la code action dell'LSP, quindi usiamo cy / cn.)
    { "<leader>cy", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Claude Code: Accetta diff" },
    { "<leader>cn", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Claude Code: Rifiuta diff" },
  },

  opts = {
    -- Avvia in automatico il server WebSocket a cui si aggancia la CLI `claude`.
    auto_start = true,
    log_level = "info",
    -- Comando per lanciare la CLI (nil = usa `claude` nel PATH).
    terminal_cmd = nil,

    terminal = {
      split_side = "right",
      split_width_percentage = 0.40,
      provider = "native", -- terminale nativo di Neovim, niente snacks
      auto_close = true,
    },

    diff_opts = {
      auto_close_on_accept = true,
      show_diff_stats = true,
      vertical_split = true,
      open_in_current_tab = true,
    },
  },

  init = function()
    -- Spostamento tra finestre da DENTRO il terminale di Claude. 
    -- <C-j> resta libero perche' a Claude serve per l'a capo nel prompt: per
    -- cambiare finestra usiamo il prefisso standard di Vim <C-w> + direzione.
    local function map_if_free(mode, lhs, rhs, opts)
      if vim.fn.maparg(lhs, mode) ~= "" then
        return
      end
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    for _, dir in ipairs({ "h", "j", "k", "l", "w", "p" }) do
      map_if_free("t", "<C-w>" .. dir, [[<C-\><C-n><C-w>]] .. dir, {
        desc = "Claude Code: vai alla finestra " .. dir,
      })
    end
  end,
}
