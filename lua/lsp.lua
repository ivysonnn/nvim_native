-- lsp
vim.lsp.enable({ "lua_ls", "tsgo", "gopls", "rust_analyzer", "clangd" })
vim.diagnostic.config({ virtual_text = true })

-- Menu anchored at the cursor, nothing preselected (so <CR> is still a plain
-- newline) and the item docs in a preview window.
vim.o.completeopt = "menu,popup,noselect,menuone,preview"

local M = {}

-- Highlight group used for each completion kind, reusing the groups the
-- colorscheme already applies to that kind of code.
local kind_hl = {
	Method = "Function",
	Function = "Function",
	Constructor = "Function",
	Field = "Identifier",
	Variable = "Identifier",
	Parameter = "Identifier",
	Property = "Identifier",
	EnumMember = "Constant",
	Constant = "Constant",
	Module = "Constant",
	Class = "Type",
	Struct = "Type",
	Interface = "Type",
	Enum = "Type",
	Event = "Type",
	TypeParameter = "Type",
	Keyword = "Keyword",
	Operator = "Operator",
	Snippet = "Special",
	Value = "Number",
	Unit = "Number",
	File = "Identifier",
	Folder = "Identifier",
	Reference = "Identifier",
	Text = "Comment",
}

--- Transforms a `lsp.CompletionItem` into a |complete-items| entry.
---
--- Neovim's default already fills in word, info and the deprecated highlight;
--- this only adds the icon, the type next to the label and the server name.
---@param item lsp.CompletionItem
---@param source string Name of the server that produced the item.
---@return table
function M.to_vim_item(item, source)
	local out = {}

	local label_details = item.labelDetails or {}
	local detail = label_details.detail or item.detail
	out.abbr = detail and (item.label .. "  " .. detail) or item.label
	out.menu = label_details.description or source

	local name = item.kind and vim.lsp.protocol.CompletionItemKind[item.kind]
	-- Colors keep the swatch the runtime generates from the item documentation.
	if name and name ~= "Color" then
		-- lspkind only enters the runtimepath when lazy loads it, and the
		-- conversion happens after that, so require it here.
		local icon = require("lspkind").symbolic(name, { mode = "symbol" })
		if icon ~= "" then
			out.kind = icon
			out.kind_hlgroup = kind_hl[name] or "DiagnosticInfo"
		end
	end

	return out
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client ~= nil and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, {
				autotrigger = true,
				convert = function(item)
					return M.to_vim_item(item, client.name)
				end,
			})
		end
	end,
})

return M
