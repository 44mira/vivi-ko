return {
	"ggandor/leap.nvim",
	init = function()
		local bind = function(lhs, rhs, desc)
			vim.keymap.set({ "n", "x", "o" }, lhs, rhs, { desc = desc })
		end

		bind("<leader>l", "<Plug>(leap)")
	end,
}
