# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository (生存装备库 - "Survival Equipment Library") containing configuration files for Neovim, zsh, iTerm2, and fonts.

## Repository Structure

```
├── .config/nvim/          # Neovim configuration
│   ├── init.lua           # Entry point
│   ├── lazy-lock.json     # Plugin lock file
│   ├── lua/config/        # Core config (options, keymaps, lazy setup)
│   ├── lua/plugin_config/ # Individual plugin configs
│   └── lua/lsp_client_config/ # LSP server configs
├── .zshrc                 # zsh shell configuration
├── iterm2/                # iTerm2 profile/settings
├── font/FiraCode/         # Fira Code Nerd Font variants
└── README.md              # Installation instructions
```

## Neovim Configuration

### Plugin Manager
- Uses [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager
- Plugin definitions are in `lua/config/lazy.lua`
- Lock file at `lazy-lock.json` ensures reproducible installs

### Key Plugins
- **UI**: vscode.nvim (colorscheme), nvim-tree (file explorer), bufferline (tabs), lualine (statusline)
- **Navigation**: telescope.nvim (fuzzy finder)
- **Editing**: Comment.nvim, nvim-treesitter (syntax highlighting, folding)
- **LSP**: mason.nvim (package manager), nvim-lspconfig

### LSP Configuration
Uses Neovim 0.11+ native LSP APIs:
- `lua/lsp_client_config/luals.lua` - Lua language server config
- `lua/lsp_client_config/clangd.lua` - C/C++ language server config

### VS Code Support
The config detects VS Code Neovim extension (`vim.g.vscode`) and loads minimal keymaps from `lua/config/keymaps_vscode.lua`.

## zsh Configuration

Key aliases defined in `.zshrc`:
- **Git**: `gs` (status), `gr` (remote), `gl` (log), `gc` (commit)
- **ls**: `ll` (ls -al), `la` (ls -A), `l` (ls -CF)
- **Editor**: `v` (nvim)

Note: Contains hardcoded path `/Users/baijiaao/.openclaw/completions/openclaw.zsh` for OpenClaw completion.

## Installation

As documented in README.md, use copy-based installation:

```bash
# Neovim config
mkdir -p ~/.config
cp -rv .config/nvim ~/.config/

# zsh config
cp .zshrc ~/.zshrc
```

## Notes for AI Assistants

- Configuration files contain Chinese comments
- This is a personal dotfiles repo - changes should respect the existing structure
- Plugin versions are locked - updating plugins requires modifying `lazy-lock.json`
- LSP configs use newer Neovim 0.11+ APIs (`vim.lsp.config()`, `vim.lsp.enable()`)
