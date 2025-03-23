return {
	"nvim-orgmode/telescope-orgmode.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-orgmode/orgmode",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local telescope = require("telescope")
		telescope.load_extension("orgmode")

		vim.keymap.set(
			"n",
			"<leader>to",
			telescope.extensions.orgmode.refile_heading,
			{ desc = "Refile current heading" }
		)
		vim.keymap.set("n", "<leader>soo", function()
			telescope.extensions.orgmode.search_headings({ mode = "orgfiles" })
		end, { desc = "Search orgfiles" })
		vim.keymap.set(
			"n",
			"<leader>soh",
			telescope.extensions.orgmode.search_headings,
			{ desc = "Search orgfile headers" }
		)
	end,
}
