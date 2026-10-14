-- Snippets with the native vim.snippet module. Type the trigger and press
-- <C-l>; once expanded, <C-l>, <Tab> and <S-Tab> walk the placeholders.
---@class Snippets
local M = {}

---@type table<string, table<string, string>>
M.snippets = {
	-- shared by every filetype
	all = {
		fori = "for ${1:i} = ${2:1}, ${3:10} do\n\t$0\nend",
		ife = "if $1 then\n\t$0\nend",
	},
	lua = {
		fn = "function ${1:name}($2)\n\t$0\nend",
		lfn = "local function ${1:name}($2)\n\t$0\nend",
		fore = "for _, ${1:value} in ipairs(${2:list}) do\n\t$0\nend",
	},
	typescript = {
		fn = "function ${1:name}($2) {\n\t$0\n}",
		afn = "const ${1:name} = (${2}) => {\n\t$0\n}",
		log = "console.log($0)",
	},
	go = {
		func = "func ${1:name}($2) $3 {\n\t$0\n}",
	},
	rust = {
		fn = "fn ${1:name}($2) -> $3 {\n\t$0\n}",
		main = "fn main() {\n\t$0\n}",
	},
}

M.snippets.javascript = M.snippets.typescript
M.snippets.javascriptreact = M.snippets.typescript
M.snippets.typescriptreact = M.snippets.typescript

function M.snippets_for(filetype)
	return vim.tbl_extend("keep", M.snippets[filetype] or {}, M.snippets.all)
end

-- The word right before the cursor, e.g. the `fn` in `str:fn`.
local function trigger()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row, col = cursor[1], cursor[2]
	local line = vim.api.nvim_get_current_line()
	local word = line:sub(1, col):match("[%w_]+$") or ""
	return row, col, word
end

function M.expand_or_jump()
	if vim.snippet.active({ direction = 1 }) then
		vim.snippet.jump(1)
		return
	end

	local row, col, word = trigger()
	if word == "" then
		return
	end

	local snippet = M.snippets_for(vim.bo.filetype)[word]
	if not snippet then
		return
	end

	vim.api.nvim_buf_set_text(0, row - 1, col - #word, row - 1, col, {})
	vim.snippet.expand(snippet)
end

function M.jump_back()
	if vim.snippet.active({ direction = -1 }) then
		vim.snippet.jump(-1)
	end
end

-- <Tab> keeps its normal meaning unless a snippet is being filled in.
vim.keymap.set({ "i", "s" }, "<Tab>", function()
	if vim.snippet.active({ direction = 1 }) then
		vim.snippet.jump(1)
		return ""
	end
	return "<Tab>"
end, { expr = true, silent = true, desc = "Next snippet tabstop" })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
	if vim.snippet.active({ direction = -1 }) then
		vim.snippet.jump(-1)
		return ""
	end
	return "<S-Tab>"
end, { expr = true, silent = true, desc = "Previous snippet tabstop" })

vim.keymap.set("i", "<C-l>", M.expand_or_jump, { silent = true, desc = "Expand snippet" })
vim.keymap.set("i", "<S-l>", M.jump_back, { silent = true, desc = "Previous snippet tabstop" })

return M
