local function bind(lhs, rhs, desc)
	vim.keymap.set("n", lhs, rhs, { desc = desc })
end

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({})

		local builtin = require("telescope.builtin")

		bind("<leader>sf", builtin.find_files, "Search files")
		bind("<leader>sg", builtin.live_grep, "Grep files")
		bind("<leader><leader>", builtin.buffers, "Search buffers")
		bind("<leader>sd", builtin.diagnostics, "Search Document diagnostics")
		bind("<leader>s/", builtin.current_buffer_fuzzy_find, "Search in file")
	end,
}
