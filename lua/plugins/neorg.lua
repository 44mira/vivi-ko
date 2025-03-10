local root = "~/neorg"

return {
	"nvim-neorg/neorg",
	lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
	version = "*", -- Pin Neorg to the latest stable release
	config = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-neorg/neorg-telescope",
		"benlubas/neorg-conceal-wrap",
		"folke/zen-mode.nvim",
		"dhruvasagar/vim-table-mode",
	},
	opts = {
		-- Plugins {{{
		load = {
			["core.defaults"] = {},
			["core.clipboard.code-blocks"] = {},
			["core.integrations.treesitter"] = {},
			["core.concealer"] = {},
			["core.qol.toc"] = {
				config = {
					fixed_width = 40,
				},
			},
			["core.completion"] = {
				config = {
					engine = "nvim-cmp",
				},
			},
			["core.integrations.nvim-cmp"] = {},
			["core.dirman"] = {
				config = {
					workspaces = {
						neorg = root,
						datacamp = root .. "/datacamp",
						thesis = root .. "/thesis",
						misc = root .. "/misc",
						school = root .. "/school",
					},
					default_workspace = "neorg",
				},
			},
			["core.export"] = {},
			["core.integrations.telescope"] = {},
			["external.conceal-wrap"] = {},
		}, -- }}}
	},
	init = function()
		vim.keymap.set(
			"n",
			"<leader>sww",
			"<Plug>(neorg.telescope.switch_workspace)",
			{ desc = "Switch Neorg workspace" }
		)

		vim.keymap.set("n", "<leader>swr", "<CMD>Neorg return<CR>", { desc = "Return to previous working document" })

		vim.api.nvim_create_autocmd("Filetype", {
			pattern = "norg",
			callback = function()
				-- vim.g.table_mode_corner = "|"

				local bind = function(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { desc = desc, buffer = true })
				end

				bind("<leader>to", "<CMD>Neorg toc right<CR>", "Table of contents")
				bind("<leader>co", "<Plug>(neorg.looking-glass.magnify-code-block)", "Use Looking Glass")
			end,
		})
	end,
}
