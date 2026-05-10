return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      -- Setup UI ottimizzata
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.40 },      -- Variabili/Registri (più grande)
              { id = "breakpoints", size = 0.20 }, -- Breakpoints
              { id = "stacks", size = 0.20 },      -- Stack
              { id = "watches", size = 0.20 },     -- Watch
            },
            size = 50,         -- Larghezza sidebar
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.6 },    -- Console GDB
              { id = "console", size = 0.4 }, -- Output programma
            },
            size = 12,         -- Altezza bottom bar
            position = "bottom",
          },
        },
        controls = {
          enabled = true,
          element = "repl",
        },
        floating = {
          max_height = 0.9,
          max_width = 0.9,
          border = "rounded",
        },
        render = {
          max_type_length = nil,
          max_value_lines = 100,
        }
      })

      -- Adapter cpptools da Mason
      dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = vim.fn.stdpath('data') .. '/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
      }

      -- Configurazione Assembly
      dap.configurations.asm = {
        {
          name = "Debug Assembly",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input('Executable: ', vim.fn.getcwd() .. '/build/file', 'file')
          end,
          args = function()
            local input = vim.fn.input('Arguments: ')
            if input == "" then return {} end
            return vim.split(input, " ")
          end,
          stopAtEntry = true,
          cwd = '${workspaceFolder}',
          environment = {},
          externalConsole = false,
          MIMode = "gdb",
          miDebuggerPath = "/usr/bin/gdb",
          setupCommands = {
            {
              text = '-enable-pretty-printing',
              ignoreFailures = false
            },
          },
        },
      }

      dap.configurations.s = dap.configurations.asm

      -- Auto open/close UI
      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      -- NON chiudere automaticamente (per assembly)
      -- dap.listeners.before.event_terminated['dapui_config'] = dapui.close

      -- Keybindings
      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Continue' })
      vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
      vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Step Over' })
      vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Step Into' })
      vim.keymap.set('n', '<S-F11>', dap.step_out, { desc = 'Step Out' })
      vim.keymap.set('n', '<S-F5>', dap.terminate, { desc = 'Stop' })
      vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Toggle UI' })

      -- Segni più visibili
      vim.fn.sign_define('DapBreakpoint', { 
        text='🔴', 
        texthl='DapBreakpoint', 
        linehl='DapBreakpointLine', 
        numhl='DapBreakpoint'
      })
      vim.fn.sign_define('DapStopped', { 
        text='▶️', 
        texthl='DapStopped', 
        linehl='DapStoppedLine', 
        numhl='DapStopped'
      })

      -- Colori più evidenti
      vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#ff0000' })
      vim.api.nvim_set_hl(0, 'DapBreakpointLine', { bg = '#3d1f1f' })
      vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#00ff00' })
      vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#2d4d2d' })
    end
  },
}
