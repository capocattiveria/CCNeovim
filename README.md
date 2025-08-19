# CCNeovim
## Introduction

This is my Neovim configuration, I started this from the repository:

- [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)

I change the directory structure for a little bit of modularity: 

```bash
├── doc
├── init.lua
├── lazy-lock.json
├── LICENSE.md
├── lua
│   ├── plugins
│   │   ├── buffer_line.lua
│   │   ├── colorscheme.lua
│   │   ├── conform.lua
│   │   ├── copilot.lua
│   │   ├── keymap.lua
│   │   ├── lsp_plugins.lua
│   │   ├── mini.lua
│   │   ├── neo-tree.lua
│   │   ├── nvim-cmp.lua
│   │   ├── telescope.lua
│   │   ├── treesitter.lua
│   │   └── which_key.lua
│   └── plugins_setup.lua
└── README.md
```

### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true

> **NOTE**

Neovim's configurations are located under the following paths:
Linux: `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim`

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
current plugin status. Hit `q` to close the window.

