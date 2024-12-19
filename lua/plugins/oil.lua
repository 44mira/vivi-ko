--[[
This plugin lets us open a Neovim buffer as a file explorer,
allowing us to use our default motions to navigate the file system.

Notable keymappings (with <leader> as <space>):

<leader>f : Open an Oil buffer on the current file
--]]


return {
  'stevearc/oil.nvim',
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  lazy = false,
  keys = {
    { "<leader>f", "<cmd>Oil<cr>", { desc = "Open Oil buffer" } }
  },
  config = function()
    require('oil').setup {
      default_file_explorer = true
    }
  end
}
