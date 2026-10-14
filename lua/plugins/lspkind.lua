return {
	"nvim-tree/lspkind.nvim",
	-- Only the kind -> icon map is used, loaded by the completion `convert`
	-- hook. It has to be in the runtimepath before the first completion, and
	-- a plain `require` inside the hook would fail if lazy had not loaded it
	-- yet, so keep it as a startup plugin.
	lazy = false,
}
