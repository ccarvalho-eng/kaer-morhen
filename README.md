# Kaer Morhen

Minimal Neovim configuration optimized for Elixir development with modern tooling and AI assistance.

## Features

- **LSP** - ElixirLS with Dialyzer, test lenses, format-on-save
- **Completion** - nvim-cmp with LSP, buffer, path, and snippets
- **Git** - Gitsigns, Fugitive, LazyGit integration
- **Fuzzy Finder** - Telescope with FZF native
- **Testing** - vim-test + IEx terminal integration
- **AI** - Claude Code integration with diff support
- **Editor** - Auto-pairs, surround, smart commenting, Treesitter

## Installation

```bash
git clone git@github.com:ccarvalho-eng/kaer-morhen.git ~/.config/nvim-vanilla
nvim  # Plugins install automatically on first launch
```

Run `:PackerSync` to update plugins.

## Documentation

- [Keymaps Reference](docs/keymaps.md)

## Philosophy

Less is more. This configuration prioritizes simplicity and performance over feature bloat.
