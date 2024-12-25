-- set line numbers
vim.o.number = true
vim.o.relativenumber = true

-- use system clipboard
vim.o.clipboard = "unnamedplus"

-- tab settings
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- set gitsigns column
vim.o.signcolumn = "yes"

-- keep history
vim.opt.undofile = true

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- highlight the line your cursor is on
vim.opt.cursorline = true

-- vertical padding for cursor
vim.opt.scrolloff = 2

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Use global statusline
vim.o.laststatus = 3

-- Use marker folds
vim.o.foldmethod = 'marker'

FoldText = function()
  local foldStart = vim.fn.getline(vim.v.foldstart)
  -- formatting block {{{1
  local title = foldStart:gmatch('%s*[^%s]* (.+) {{{.*')
  local icon = "🟆 "
  -- }}}1
  return icon .. ('[[ %s ]]'):format(title())
end

vim.o.foldlevelstart = 0
vim.o.foldtext = 'v:lua.FoldText()'

-- autocommands {{{
-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = "Highlight text when yanking",
  group = vim.api.nvim_create_augroup('vivi-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end
})

-- create augroup for fold states
vim.api.nvim_create_augroup('vivi-fold-state', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = "Save fold state when saving",
  group = 'vivi-fold-state',
  callback = function()
    vim.cmd "mkview!"
  end
})

vim.api.nvim_create_autocmd('BufWritePost', {
  desc = "Load fold state when reading",
  group = 'vivi-fold-state',
  callback = function()
    vim.cmd "loadview"
  end
})
-- }}}

require('vivi.keymaps')
require('vivi.lazy')
