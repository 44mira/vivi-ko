return {
	"nvim-orgmode/orgmode",
	dependencies = {
		{
			"akinsho/org-bullets.nvim",
			config = function()
				local heading_icons = { "║", "│", "╎", "┆", "┊", "⊜", "⊖", "⊘" }
				local headings = {}

				for i = 0, 7 do
					headings[i] = { heading_icons[i % #heading_icons + 1], ("@org.headline.level%d"):format(i) }
				end

				require("org-bullets").setup({
					concealcursor = true,
					symbols = {
						list = "•",
						headlines = headings,
						checkboxes = {
							half = { "", "@org.checkbox.halfchecked" },
							done = { "✓", "@org.keyword.done" },
							todo = { "˟", "@org.keyword.todo" },
						},
					},
				})
			end,
		},
		{
			"michaelb/sniprun",
			branch = "master",
			build = "sh install.sh",
			opts = {
				display = {
					"TerminalWithCode",
				},
			},
		},
	},
	event = "VeryLazy",
	-- config {{{
	config = function(_, opts)
		local orgmode = require("orgmode")
		local sniprun = require("sniprun")
		sniprun.display = require("sniprun.display")

		orgmode.setup(opts)

		-- org specific keymaps
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "org",
			callback = function()
				-- use return to for context-aware new
				vim.keymap.set("i", "<C-CR>", '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>', {
					silent = true,
					buffer = true,
				})

				vim.keymap.set("n", "<leader>obr", sniprun.run, { desc = "Run code snippet " })
				vim.keymap.set("n", "<leader>obc", sniprun.display.close_all, { desc = "Close code snippet " })
			end,
		})
	end,
	-- }}}
	opts = {
		-- Default files
		org_agenda_files = "~/orgfiles/**/*",
		org_default_notes_file = "~/orgfiles/refile.org",

		-- Settings {{{
		org_hide_emphasis_markers = true,
		org_startup_folded = "inherit",
		org_hide_leading_stars = true,
		org_startup_indented = true,
		org_indent_mode_turns_on_hiding_stars = false,
		-- }}}

		-- Templates
		org_capture_templates = {
			t = { description = "Task", template = "* TODO %?\n %u" },
			s = { description = "Scratch", template = "* %U\n%?" },
		},
	},
}
