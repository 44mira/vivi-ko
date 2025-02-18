local dashboard_config = {
	enabled = true,

	preset = {

		keys = {
			{
				icon = " ",
				key = "n",
				desc = "Configure Neovim",
				action = ":cd ~/.config/nvim | e .",
			},
			{
				icon = "󰄛",
				key = "k",
				desc = "Configure Kitty",
				action = ":cd ~/.config/kitty | e .",
			},
			{
				icon = "󰨇",
				key = "h",
				desc = "Configure Hyprland",
				action = ":cd ~/.config/hypr | e .",
			},
			{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
		},
	},

	sections = {
		{ section = "header" },
		{
			section = "terminal",
			pane = 2,
			cmd = "pipes.sh -p 2 -t 3",
			height = 3,
			padding = 1,
		},
		{ icon = "■", title = "Recent Files", section = "recent_files", pane = 1, indent = 2, padding = 1 },
		{ section = "keys", padding = 1 },
		-- Git info {{{
		function()
			local in_git = Snacks.git.get_root() ~= nil

			local cmds = {
				{
					title = "Open Issues",
					cmd = "gh issue list -L 3",
					key = "i",
					action = function()
						vim.fn.jobstart("gh issue list --web", { detach = true })
					end,
					icon = " ",
					height = 4,
				},
				{
					icon = " ",
					title = "Open PRs",
					cmd = "gh pr list -L 3",
					key = "P",
					action = function()
						vim.fn.jobstart("gh pr list --web", { detach = true })
					end,
					height = 4,
				},
				{
					icon = " ",
					title = "Git Status",
					cmd = "git --no-pager diff --stat -B -M -C",
					height = 4,
				},
			}

			return vim.tbl_map(function(cmd)
				return vim.tbl_extend("force", {
					pane = 2,
					section = "terminal",
					enabled = in_git,
					padding = 1,
					ttl = 5 * 60,
					indent = 3,
				}, cmd)
			end, cmds)
		end, -- }}}
		{
			pane = 2,
			icon = " ",
			desc = "Browse Repo",
			padding = 1,
			key = "b",
			action = function()
				Snacks.gitbrowse()
			end,
		},
	},
}

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		image = { enabled = true },
		indent = { enabled = false },
		statuscolumn = { enabled = true },
		scope = { enabled = true },
		bufdelete = { enabled = true },
		dashboard = dashboard_config,
	},
	init = function()
		vim.api.nvim_create_user_command("Dash", function()
			Snacks.dashboard.open()
		end, {})
	end,
	-- Keymaps {{{
	keys = {
		{
			"<leader>bd",
			function()
				Snacks.bufdelete.delete()
			end,
			desc = "Buffer delete",
		},
		{
			"<leader>bo",
			function()
				Snacks.bufdelete.other()
			end,
			desc = "Delete other buffers",
		},
		{
			"<leader>cc",
			function()
				if not Snacks.indent.enabled then
					Snacks.indent.enable()
				else
					Snacks.indent.disable()
				end

				if vim.o.colorcolumn ~= "" then
					vim.o.colorcolumn = ""
					return
				end

				if vim.v.count ~= 0 then
					vim.o.colorcolumn = vim.v.count .. ""
				else
					vim.o.colorcolumn = "80"
				end
			end,
			desc = "Toggle indent labels",
		},
	}, -- }}}
}
