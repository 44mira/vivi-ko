return {
	"michaelrommel/nvim-silicon",
	opts = {
		font = "Iosevka Nerd Font Mono=16",
		background = "#252423",
		theme = "gruvbox-dark",
		tab_width = 2,
		gobble = true,
		shadow_color = "#100808",
	},
	init = function()
		local ns = require("nvim-silicon")

		vim.keymap.set("v", "<leader><leader>", function()
			ns.clip()
		end, { desc = "Copy code screenshot" })
	end,
}
