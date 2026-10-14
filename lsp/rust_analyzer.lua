-- LSP configuration for Rust.
--
-- Server: https://rust-analyzer.github.io
--
-- Installed system-wide (Fedora, version-matched to the toolchain):
--   sudo dnf install rust-analyzer
--
-- rust-analyzer is workspace aware: it needs `cargo metadata` to find the
-- crate root, so root_dir is a function rather than a static marker list.

return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	settings = {
		["rust-analyzer"] = {
			-- Code lenses above functions: references, implementations, run/debug.
			lens = {
				enable = true,
				debug = { enable = true },
				implementations = { enable = true },
				references = {
					adt = { enable = true },
					enumVariant = { enable = true },
					method = { enable = true },
					trait = { enable = true },
				},
				run = { enable = true },
				updateTest = { enable = true },
			},
			-- Highlight the placeholders that cargo build would fill in,
			-- e.g. `todo!()`, `unimplemented!()`.
			highlightRelated = { enable = true },
		},
	},
	before_init = function(init_params, config)
		-- rust-analyzer reads its configuration from initializationOptions,
		-- which Neovim only fills in from the settings table above.
		if config.settings and config.settings["rust-analyzer"] then
			init_params.initializationOptions = config.settings["rust-analyzer"]
		end
	end,
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)

		-- Standalone file or a project without Cargo.toml.
		local crate_dir = vim.fs.root(bufnr, "Cargo.toml")
		if not crate_dir then
			on_dir(vim.fs.root(bufnr, "rust-project.json"))
			return
		end

		-- A crate inside a workspace: ask cargo, since the workspace root can
		-- live several levels above the Cargo.toml.
		vim.system(
			{
				"cargo",
				"metadata",
				"--no-deps",
				"--format-version",
				"1",
				"--manifest-path",
				vim.fs.joinpath(crate_dir, "Cargo.toml"),
			},
			{ text = true },
			function(out)
				local root = crate_dir
				if out.code == 0 and out.stdout then
					local ok, meta = pcall(vim.json.decode, out.stdout)
					if ok and meta.workspace_root then
						root = vim.fs.normalize(meta.workspace_root)
					end
				end
				on_dir(root)
			end
		)
	end,
}
