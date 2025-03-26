local bind = vim.keymap.set

-- map the leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ergonomic normal mode
bind("i", "jk", "<Esc>", { desc = "Normal mode" })

-- bind('n', '<Esc>', '<cmd>nohl<cr>', { desc = 'Clear highlight' })
vim.o.hlsearch = true

---@deprecated Use oil.nvim
-- bind('n', '<leader>f', '<cmd>Ex<cr>', { desc = 'Open file explorer' })

-- window navigation
for direction in ("hjkl"):gmatch(".") do
	bind("n", ("<C-%s>"):format(direction), ("<C-w><C-%s>"):format(direction), {
		desc = "Window" .. direction,
	})
end

-- buffer navigation
bind("n", "<leader>[", "<cmd>bp<cr>", { desc = "Previous buffer" })
bind("n", "<leader>]", "<cmd>bn<cr>", { desc = "Next buffer" })

-- moveline {{{
---@param direction integer The direction of the move
---@return fun() : nil # The callback for moving
local function moveline(direction)
	return function()
		local cursor, c = vim.fn.line("."), vim.fn.line("$")

		local new_address = cursor + direction * vim.v.count1

		-- edge check
		if new_address < 0 or new_address > c then
			return
		end

		local out = "move " .. new_address

		vim.cmd(out)
	end
end
-- }}}
--
bind("n", "<M-Down>", moveline(1), { desc = "Move line down" })
bind("n", "<M-Up>", moveline(-2), { desc = "Move line up" })
