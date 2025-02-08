return {
  "OXY2DEV/markview.nvim",
  lazy = false,

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },

  opts = {
    markdown = {
      enable = false
    }
  },

  init = function()
    local markview = require("markview")

    vim.keymap.set("n", "<leader>mv", "<cmd>Markview toggle<cr>", { desc = "Toggle Markview" })
  end
}
