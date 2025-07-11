vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- set to true if you have a nerd font installed and selected in the terminal
vim.g.have_nerd_font = true
vim.opt.guicursor = 'n-v-i-c:block-Cursor'

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.termguicolors = true -- Enable true color
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.confirm = true
vim.opt.tabstop = 4 -- Set tab width
vim.opt.shiftwidth = 4
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 4
vim.opt.colorcolumn = '80'

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>x', ':!chmod +x %<CR>')

vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>') -- clear search highlight
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')

-- better navigation & editing
vim.keymap.set('n', 'x', '"_x') -- delete without yanking
vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('i', 'JK', '<ESC>')
vim.keymap.set('n', '<leader>w', [[:%s/\s\+$//e<CR>]]) -- Trim trailing whitespace
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gvzz") -- Move selected text down
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gvzz") -- Move selected text up
vim.keymap.set('v', '<', '<gv') -- Indent left
vim.keymap.set('v', '>', '>gv') -- Indent right
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex) -- Open file explorer
vim.keymap.set('n', '<C-d>', '<C-d>zz') -- Center after page down
vim.keymap.set('n', '<C-u>', '<C-u>zz') -- Center after page up
vim.keymap.set('n', 'n', 'nzz') -- Keep search results centered
vim.keymap.set('n', 'N', 'Nzz')
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- highlight yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local show_virtual_text = true

vim.keymap.set('n', '<leader>tv', function()
  show_virtual_text = not show_virtual_text
  vim.diagnostic.config {
    virtual_text = show_virtual_text,
  }
  vim.notify('virtual_text: ' .. (show_virtual_text and 'on' or 'off'))
end, { desc = '[T]oggle LSP [V]irtual text' })

-- clean up whitespace
local disable_cleanup = {
  markdown = true,
  text = true,
}

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if disable_cleanup[ft] then
      return
    end

    vim.api.nvim_buf_call(args.buf, function()
      vim.cmd [[%s/\s\+$//e]]
      vim.cmd [[:silent! %s#\($\n\s*\)\+\%$##]]
    end)
  end,
})

-- only apply these settings to c and cpp files
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp' },
  callback = function()
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
    vim.opt_local.softtabstop = 0
    vim.opt_local.expandtab = false
  end,
})

-- install lazy-nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup {
  { import = 'custom.plugins' },
}

vim.opt.background = 'dark' -- set this to dark or light
vim.cmd 'colorscheme oxocarbon'
-- vim: ts=2 sts=2 sw=2 et
