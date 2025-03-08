return {
	"ThePrimeagen/harpoon",
	init = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "<leader>mk", function()
			ui.toggle_quick_menu()
		end, { desc = "Toggle Harpoon menu" })
		vim.keymap.set("n", "<leader>mm", function()
			mark.add_file()
		end, { desc = "Mark a file for Harpoon" })

		for i = 1, 9 do
			vim.keymap.set("n", ("<M-%d>"):format(i), function()
				ui.nav_file(i)
			end, { desc = "Jump to Harpoon marked file " .. i })
		end
	end,
}
