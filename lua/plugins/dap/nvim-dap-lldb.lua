return {
	"julianolf/nvim-dap-lldb",
	dependencies = { "mfussenegger/nvim-dap" },
	opts = {
		codelldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/codelldb",
	},
}
