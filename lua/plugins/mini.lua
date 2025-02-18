--[[
This plugin is a collection of mini-plugins that aim to have miscellaneous
functions for Neovim.

Notable keybindings (with <leader> as <space>):

<text-object> ::= these are motions that form a selection such as `aw`, `i)`

sa<text-object><character> : surround <text-object> with <character>
sa<text-object>t           : surround <text-object> with an HTML tag
sa<text-object>f           : surround <text-object> with parentheses and a
                             function name
sd<character>              : delete surrounding <character>
sr<character>              : replace surrounding <character>
--]]

local config_dirs = {
	{ "Neovim", "~/.config/nvim" },
	{ "kitty", "~/.config/kitty" },
	{ "Hyprland", "~/.config/hypr" },
}

return {
	"echasnovski/mini.nvim",
	version = "*",
	init = function()
		-- around-inside text objects
		require("mini.ai").setup()

		-- auto pairing
		require("mini.pairs").setup()

		-- surround actions
		require("mini.surround").setup()

		-- statusline
		-- require('mini.statusline').setup()

		-- start page
		-- local starter = require("mini.starter")
		-- starter.setup({
		-- 	items = {
		-- 		starter.sections.recent_files(),
		-- 		function()
		-- 			local builtin_actions = {}
		--
		-- 			for _, v in ipairs(config_dirs) do
		-- 				local name, directory = unpack(v)
		-- 				local item = {
		-- 					name = "Configure " .. name,
		-- 					action = "cd " .. directory .. " | e .",
		-- 					section = "Builtin actions",
		-- 				}
		--
		-- 				table.insert(builtin_actions, item)
		-- 			end
		--
		-- 			return builtin_actions
		-- 		end,
		-- 		starter.sections.builtin_actions(),
		-- 	},
		-- 	content_hooks = {
		-- 		starter.gen_hook.adding_bullet(),
		-- 		starter.gen_hook.aligning("center", "center"),
		-- 		starter.gen_hook.indexing("all", { "Recent files" }),
		-- 	},
		-- })
	end,
}
