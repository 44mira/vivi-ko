--[[
This plugin gives Neovim a fuzzy-finder panel. This allows us to search on
various groups and perform actions based on pre-defined functions.

Try out `<leader>sk` to search for normal mode keymaps!

Relevant keybindings can be found in the code below, all inside `bind` calls.
--]]

local bind = function(lhs, rhs, desc)
  vim.keymap.set('n', lhs, rhs, { desc = desc })
end

return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons", "OXY2DEV/markview.nvim" },
  opts = {
    previewers = {
      builtin = {
        extensions = {
          ['png'] = { "viu" },
          ['jpg'] = { "viu" },
        }
      }
    }
  },
  init = function()
    local fzf = require('fzf-lua')

    bind('<leader>sf', fzf.files, 'Search files')
    bind('<leader>sg', fzf.live_grep, 'Grep files')
    -- bind('<leader>sb', fzf.buffers, 'Search buffers')
  end
}
