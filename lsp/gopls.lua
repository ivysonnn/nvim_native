-- LSP configuration for Go.
--
-- Server: https://pkg.go.dev/golang.org/x/tools/gopls
--
-- Installed via mason-ls, which init.lua puts on $PATH.
--   nvim lsp/gopls.lua   then  :LspInfo

return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	-- go.work for workspaces, go.mod for a single module, .git as a fallback.
	root_markers = { "go.work", "go.mod", ".git" },
	settings = {
		gopls = {
			-- gofumpt rewrites more aggressively than gofmt; only run it if
			-- you actually have it installed and want the stricter style.
			gofumpt = false,
			-- Keep completion usable while the file is still being typed.
			completeUnimported = true,
			usePlaceholders = true,
			-- Surface the usual suspects: nil derefs, dead params, etc.
			analyses = {
				nilness = true,
				unusedparams = true,
				unusedwrite = true,
			},
			-- Highlight types/params inline. gopls stopped advertising these
			-- by default, so ask for them explicitly.
			semanticTokens = true,
		},
	},
}
