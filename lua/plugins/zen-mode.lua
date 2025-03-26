return {
	"folke/zen-mode.nvim",
	opts = {
		plugins = {
			options = {
				number = false,
				relativenumber = false,
				laststatus = 0,
			},
			kitty = {
				enabled = true,
				font = "+4",
			},
		},
	},
	init = function()
		vim.keymap.set("n", "<leader>zen", require("zen-mode").toggle, { desc = "Zen mode" })
	end,
}
