local root = "~/neorg"

return {
	"nvim-neorg/neorg",
	lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
	version = "*", -- Pin Neorg to the latest stable release
	config = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-neorg/neorg-telescope",
		"folke/zen-mode.nvim",
	},
	opts = {
		load = {
			["core.clipboard.code-blocks"] = {},
			["core.ui"] = {},
			["core.integrations.treesitter"] = {},
			["core.defaults"] = {},
			["core.concealer"] = {},
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
			["core.presenter"] = {
				config = {
					zen_mode = "zen-mode",
				},
			},
			["core.integrations.telescope"] = {},
		},
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
				vim.keymap.set(
					"n",
					"<leader><right>",
					"<Plug>(neorg.presenter.next-page)",
					{ desc = "Next slide", buffer = true }
				)
				vim.keymap.set(
					"n",
					"<leader><left>",
					"<Plug>(neorg.presenter.previous-page)",
					{ desc = "Previous slide", buffer = true }
				)
			end,
		})
	end,
}
