--[[
Statusline
--]]

local function path_component()
	local h = require("slimline.highlights")
	local c = require("slimline").config

	local current_dir = vim.api.nvim_buf_get_name(0)

	local filename = vim.fs.basename(current_dir)

	local parent_path = vim.fs.normalize(vim.fs.dirname(current_dir))
	local path_list = vim.split(parent_path, "/", { trimempty = true })
	local top_3 = vim.list_slice(path_list, math.max(#path_list - 2, 0))
	local truncated_path = "../" .. vim.fn.join(top_3, "/")

	local content = {
		primary = filename ~= "" and filename or "",
		secondary = truncated_path,
	}

	return h.hl_component(content, h.hls.component, c.sep)
end

return {
	"sschleemilch/slimline.nvim",
	opts = {
		bold = true,
		verbose_mode = true,
		components = {
			left = {
				"mode",
				path_component,
				"git",
			},
		},
	},
}
