# Kaer Morhen

Neovim setup forged for Elixir work. Quiet, fast, dependable.

<img width="1673" height="1030" alt="Screenshot 2025-11-16 at 22 04 11" src="https://github.com/user-attachments/assets/79933ae5-4926-4cdf-9760-331efd281242" />

## Motivation

Vim’s a blade. Doesn’t need ornaments. Doesn’t need a full IDE strapped to its back. Just a focused kit—tools I actually use, nothing else. Starts quick, stays stable, LSP runs smooth. Lean by design. No noise.

## Features

- ElixirLS with Dialyzer, test lenses, format-on-save
- nvim-cmp with LSP, buffer, path, and snippets
- Gitsigns, Fugitive, LazyGit
- Telescope with FZF native
- vim-test + IEx terminal
- Claude Code integration
- Auto-pairs, surround, commenting, Treesitter

## Installation

```bash
git clone git@github.com:ccarvalho-eng/kaer-morhen.git ~/.config/nvim
nvim  # Plugins install on first launch
```

Run `:PackerSync` to update plugins.

## Documentation

- [Keymaps Reference](docs/keymaps.md)
