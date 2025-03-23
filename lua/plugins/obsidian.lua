return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- event = {
	-- 	vim.fn.expand("BufReadPre ~/Vault/**/*.md"),
	-- 	vim.fn.expand("BufNewFile ~/Vault/**/*.md"),
	-- },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
	},
	opts = {
		-- Either 'wiki' or 'markdown'.
		preferred_link_style = "wiki",

		-- Workspaces {{{
		workspaces = {
			{
				name = "main",
				path = "~/Vault",
			},
		},
		-- }}}
		-- Completion {{{
		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},
		-- }}}
		-- Mappings {{{
		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- Toggle check-boxes.
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
			-- Smart action depending on context, either follow link or toggle checkbox.
			["<cr>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
		},
		-- }}}
		-- Picker {{{
		picker = {
			-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
			name = "telescope.nvim",
			-- Optional, configure key mappings for the picker. These are the defaults.
			-- Not all pickers support all mappings.
			note_mappings = {
				-- Create a new note from your query.
				new = "<C-x>",
				-- Insert a link to the selected note.
				insert_link = "<C-l>",
			},
			tag_mappings = {
				-- Add tag(s) to current note.
				tag_note = "<C-x>",
				-- Insert a tag at the current location.
				insert_tag = "<C-l>",
			},
		},

		-- Optional, sort search results by "path", "modified", "accessed", or "created".
		-- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
		-- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
		sort_by = "modified",
		sort_reversed = true,
		-- }}}
		-- UI {{{
		-- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
		ui = {
			enable = false, -- set to false to disable all additional syntax features
			update_debounce = 200, -- update delay after a text change (in milliseconds)
			max_file_length = 5000, -- disable UI features for files with more than this many lines
			-- Define how various check-boxes are displayed
			checkboxes = {
				-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
				[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
				["x"] = { char = "", hl_group = "ObsidianDone" },
				[">"] = { char = "", hl_group = "ObsidianRightArrow" },
				["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
				["!"] = { char = "", hl_group = "ObsidianImportant" },
				-- Replace the above with this if you don't have a patched font:
				-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
				-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

				-- You can also add more custom ones...
			},

			-- Use bullet marks for non-checkbox lists.
			bullets = { char = "•", hl_group = "ObsidianBullet" },
			external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
			-- Replace the above with this if you don't have a patched font:
			-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
			reference_text = { hl_group = "ObsidianRefText" },
			highlight_text = { hl_group = "ObsidianHighlightText" },
			tags = { hl_group = "ObsidianTag" },
			block_ids = { hl_group = "ObsidianBlockID" },
			hl_groups = {
				-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
				ObsidianTodo = { bold = true, fg = "#fe8019" }, -- GruvboxMaterialOrange
				ObsidianDone = { bold = true, fg = "#83a598" }, -- GruvboxMaterialAqua
				ObsidianRightArrow = { bold = true, fg = "#fe8019" }, -- GruvboxMaterialOrange
				ObsidianTilde = { bold = true, fg = "#fb4934" }, -- GruvboxMaterialRed
				ObsidianImportant = { bold = true, fg = "#cc241d" }, -- GruvboxMaterialBrightRed
				ObsidianBullet = { bold = true, fg = "#83a598" }, -- GruvboxMaterialAqua
				ObsidianRefText = { underline = true, fg = "#d3869b" }, -- GruvboxMaterialPurple
				ObsidianExtLinkIcon = { fg = "#d3869b" }, -- GruvboxMaterialPurple
				ObsidianTag = { italic = true, fg = "#83a598" }, -- GruvboxMaterialAqua
				ObsidianBlockID = { italic = true, fg = "#83a598" }, -- GruvboxMaterialAqua
				ObsidianHighlightText = { bg = "#b57614" }, -- GruvboxMaterialYellow (Darkened for contrast)
			},
		},
		-- }}}
		-- Metadata {{{
		disable_frontmatter = true,
		-- }}}
		-- Link follows {{{
		-- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
		-- URL it will be ignored but you can customize this behavior here.
		---@param url string
		follow_url_func = function(url)
			-- Open the URL in the default web browser.
			vim.fn.jobstart({ "open", url }) -- Mac OS
			-- vim.fn.jobstart({"xdg-open", url})  -- linux
			-- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
			-- vim.ui.open(url) -- need Neovim 0.10.0+
		end,
		-- }}}
		-- Attachments {{{
		-- Specify how to handle attachments.
		attachments = {
			-- The default folder to place images in via `:ObsidianPasteImg`.
			-- If this is a relative path it will be interpreted as relative to the vault root.
			-- You can always override this per image by passing a full path to the command instead of just a filename.
			img_folder = "assets/imgs", -- This is the default

			-- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
			---@return string
			img_name_func = function()
				-- Prefix image names with timestamp.
				return string.format("%s-", os.time())
			end,

			-- A function that determines the text to insert in the note when pasting an image.
			-- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
			-- This is the default implementation.
			---@param client obsidian.Client
			---@param path obsidian.Path the absolute path to the image file
			---@return string
			img_text_func = function(client, path)
				path = client:vault_relative_path(path) or path
				return string.format("![%s](%s)", path.name, path)
			end,
		},
		-- }}}
		-- Daily notes {{{
		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = "dailies",
			-- Optional, if you want to change the date format for the ID of daily notes.
			date_format = "%Y-%m-%d",
			-- Optional, if you want to change the date format of the default alias of daily notes.
			alias_format = "%B %-d, %Y",
			-- Optional, default tags to add to each new daily note created.
			default_tags = { "daily-notes" },
			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
			template = nil,
		},
		-- }}}
	},
}
