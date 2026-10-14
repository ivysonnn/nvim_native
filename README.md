# Minimal Neovim

A minimal, fast Neovim configuration built mostly on Neovim 0.11+ native features, with [lazy.nvim](https://github.com/folke/lazy.nvim) managing only Telescope, nvim-tree and lspkind.

## Features

- **Native LSP** - zero-config language servers via `vim.lsp.enable()`
- **Completion** - native `vim.lsp.completion` with kind icons, the server name in the menu and docs in a preview window
- **Snippets** - `vim.snippet` with per-filetype triggers
- **Fuzzy Find** - Telescope with the fzf sorter (via `telescope-fzf-native`)
- **Live Grep** - ripgrep integration with quickfix list
- **File Tree** - nvim-tree with git status and diagnostics
- **Smart Statusline** - custom statusline with mode, git branch, diagnostics, and filetype
- **Auto Formatting** - `stylua`/`prettier` on save, with LSP fallback

## Keymaps

| Key         | Action           |
| ----------- | ---------------- |
| `<leader>e` | Toggle nvim-tree |
| `<leader>f` | Telescope find files |
| `<leader>F` | Telescope live grep |
| `<leader>o` | Telescope recent files |
| `<leader>g` | ripgrep + quickfix |
| `<leader>d` | Diagnostics quickfix |
| `<C-l>`     | Expand snippet, or next tabstop once expanded |
| `<S-l>`     | Previous tabstop |
| `<Tab>`     | Next tabstop while a snippet is active |

## Snippets

Type the trigger, then `<C-l>`. Available to every filetype: `fori`, `ife`.

| Filetype                    | Triggers            |
| --------------------------- | ------------------- |
| `lua`                       | `fn`, `lfn`, `fore` |
| `typescript`/`javascript`   | `fn`, `afn`, `log`  |
| `go`                        | `func`              |
| `rust`                      | `fn`, `main`        |

## Preview
<img width="2285" height="1351" alt="image" src="https://github.com/user-attachments/assets/ae113832-b2b1-441b-8c3a-f6862a38104c" />


## Video

Built live in this video: [youtu.be/otRvw9neQkg](https://youtu.be/otRvw9neQkg)
