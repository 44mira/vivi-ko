return {
	"nvim-orgmode/orgmode",
	dependencies = {
		{
			"akinsho/org-bullets.nvim",
			opts = {
				concealcursor = true,
				symbols = {
					list = "•",
					headlines = { "║", "│", "╎", "┆", "┊", "⊜", "⊖", "⊘" },
					checkboxes = {
						half = { "", "@org.checkbox.halfchecked" },
						done = { "", "@org.keyword.done" },
						todo = { "", "@org.keyword.todo" },
					},
				},
			},
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

		mappings = {
			org = {
				org_toggle_checkbox = { "<Leader>oxt", desc = "org toggle checkbox" },
			},
		},
	},
}
