vim.g.mapleader = " "

-- nvim-tree replaces netrw, so block the built-in file browser before it loads
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("bootstrap")
require("options")
require("lsp")
require("snippets")
require("colorscheme")
require("statusline")
require("grep")
require("autocommands")
require("diagnostics")
require("formatting")
require("keymaps")
