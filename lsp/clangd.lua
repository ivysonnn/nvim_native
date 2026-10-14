-- LSP configuration for C, C++ and Objective-C.
--
-- Server: https://clangd.llvm.org
--
-- Installed system-wide (Fedora), so nothing to install.
--   nvim lsp/clangd.lua   then  :LspInfo
--
-- clangd learns the real flags of each translation unit from a
-- JSON compilation database. Generate one next to your sources:
--   cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
-- If it lands inside build/, symlink it to the project root:
--   ln -s build/compile_commands.json .
-- With no database, clangd falls back to inferring flags by running the
-- compiler, which usually works but misses project-specific -I paths.

return {
	cmd = { "clangd", "--background-index", "--clang-tidy" },
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_markers = { "compile_commands.json", ".clangd", ".clang-tidy", ".git" },
	-- Objective-C needs the real language ids, not the filetype names.
	get_language_id = function(_, ftype)
		local map = { objc = "objective-c", objcpp = "objective-cpp", cuda = "cuda-cpp" }
		return map[ftype] or ftype
	end,
	capabilities = {
		textDocument = {
			completion = { editsNearCursor = true },
		},
	},
	settings = {
		clangd = {
			-- Re-lint files that changed on disk without being touched.
			check = { updates = { wantDiagnosticsForUnchangedFiles = true } },
		},
	},
}
