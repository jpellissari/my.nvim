# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration under the `pellissari` namespace, using `lazy.nvim` for plugin management with a modular structure.

## Formatting

Lua files use stylua (160 char column width, 2-space indent per `.stylua.toml`):

```sh
stylua lua/
```

## Architecture

**Entry point**: `init.lua` loads 4 core modules in order:
1. `pellissari.options` — editor settings (leader = `<space>`, 4-space indent, relative numbers)
2. `pellissari.remap` — global keymaps
3. `pellissari.autocmd` — autocommands
4. `pellissari.lazy` — bootstraps lazy.nvim, auto-discovers all files in `lua/pellissari/plugins/`

**Adding a plugin**: create a new file in `lua/pellissari/plugins/` returning a lazy.nvim spec. No registration needed — lazy picks it up automatically.

## Keybinding groups (which-key)

| Prefix | Group |
|--------|-------|
| `<leader>c` | Code (`ca` action, `cf` format, `cr` rename) |
| `<leader>f` | Find (files, recent, git files, buffers, projects, config) |
| `<leader>g` | Git (neogit via `gg`, status, log, branches, diff, file log) |
| `<leader>h` | Git Hunks (stage, reset, blame, diff — from gitsigns) |
| `<leader>m` | Markdown (`mz` zen mode) |
| `<leader>n` | Notes (snacks-scratch: pomodoro, idea capture, daily capture) |
| `<leader>o` | Obsidian (today, inbox, switch, search, yesterday) |
| `<leader>s` | Search (grep, help, diagnostics, LSP symbols, keymaps, notifications, search history) |
| `<leader>t` | Toggle (blame, deleted hunks, inlay hints) |

**Top-level:** `<leader><space>` smart find, `<leader>,` buffers, `<leader>/` grep, `<leader>e` oil (file manager), `<leader>u` undotree, `<leader>a` harpoon add, `<leader>1-4` harpoon files, `<leader>qq` quit all.

**LSP navigation** (via snacks picker): `gd` definition, `gr` references, `gI` implementation, `gy` type definition, `gD` declaration, `gai/gao` incoming/outgoing calls.

**Quickfix:** `]q`/`[q`. **Git hunks:** `]c`/`[c`.

## Key plugins

| Plugin | Purpose |
|--------|---------|
| `snacks.nvim` | Picker (replaces telescope), notifications, zen, indent guides, words, rename |
| `oil.nvim` | File system editing as a buffer (`<leader>e`) |
| `harpoon` | Quick file switching (`<leader>a`, `<C-e>`, `<leader>1-4`) |
| `mason` + `mason-lspconfig` | LSP server auto-install |
| `nvim-cmp` + `LuaSnip` | Completion + snippets |
| `conform.nvim` | Format on save + `<leader>cf` |
| `neogit` + `gitsigns` | Git workflow |
| `mini.nvim` | Statusline, AI text objects (`mini.ai`), surround (`mini.surround`) |
| `obsidian.nvim` + `render-markdown` | Note-taking (vault at `~/notes`) |

## LSP servers

Configured in `lua/pellissari/plugins/lsp.lua` → `servers` table: `ts_ls`, `angularls`, `gopls`, `lua_ls`. Mason installs them automatically. To add a server, add it to that table.

## Health check

`:checkhealth pellissari` — verifies Neovim 0.10+, `git`, `make`, `unzip`, `rg`.
