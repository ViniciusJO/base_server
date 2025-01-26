vim.g.mapleader = ' ';
vim.g.maplocalleader = ' ';

vim.o.hlsearch = true

vim.o.number = true
vim.o.relativenumber = false

vim.o.wrap = false

vim.o.mouse = 'a'

vim.o.breakindent = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smarttab = true
vim.o.expandtab = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.wo.signcolumn = 'yes'

vim.o.completeopt = 'menuone,noselect,preview'

vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3
vim.opt.runtimepath:remove(vim.fn.stdpath('config') .. '/autoload/netrw.vim')
vim.opt.runtimepath:remove(vim.fn.stdpath('config') .. '/plugin/netrwPlugin.vim')
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.clipboard = 'unnamedplus'

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
  group = highlight_group,
  pattern = '*',
})

vim.o.foldmethod = "syntax"
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

require('plugins.lazy').bootstrap();

require('lazy').setup({
  { import = 'plugins.cmp' },
  { import = 'plugins.lsp' },
  { import = 'plugins.dap' },
  { import = 'plugins.treesiter' },
  { import = 'plugins.mini' },
  { import = 'plugins.ufu' },
  { import = 'plugins.trouble' },
  { import = 'plugins.undo-tree' },
  { import = 'plugins.which-key' },
  { import = 'plugins.telescope' },
  { import = 'plugins.twoslash-queries' },
  { import = 'plugins.todo-comments' },
  { import = 'plugins.log_highlight' },
  { import = 'plugins.dired' },
  { import = 'plugins.vi-mongo' },
})

-- Keymaps for save and quit
vim.keymap.set('n', '<C-s>', '<cmd>w<cr>', { desc = 'Save buffer to file', silent = true })
vim.keymap.set('n', '<C-q>', '<cmd>q<cr>', { desc = 'Quit window', silent = true })
vim.keymap.set('n', '<C-Q>', '<cmd>q!<cr>', { desc = 'Quit window', silent = true })

-- Copy to systems clipboard
vim.keymap.set('n', 'Y', '"+y', { desc = 'Yank to systems clipboard' });
vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Yank to systems clipboard' });

-- Go to help
vim.keymap.set('n', 'gh', function() vim.cmd("h " .. vim.fn.expand("<cword>")) end, { desc = "Goto help", noremap = true, silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Toggle options
vim.keymap.set('n', '<M-z>', function() if(vim.o.wrap) then vim.o.wrap = false else vim.o.wrap = true end end, {desc = 'Toggle wrap', expr = true})
vim.keymap.set('n', '<M-r>', function() if(vim.o.relativenumber) then vim.o.relativenumber = false else vim.o.relativenumber = true end end, {desc = 'Toggle relative collumn number', expr = true})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- Resize window
vim.keymap.set('n', '<C-up>', '1<C-w>+', { noremap = true, silent = true, desc = 'Vertically resize windows (+)' })
vim.keymap.set('n', '<C-down>', '1<C-w>-', { noremap = true, silent = true, desc = 'Vertically resize windows (-)' })
vim.keymap.set('n', '<C-left>', '1<C-w>>', { noremap = true, silent = true, desc = 'Horizontally resize windows (+)' })
vim.keymap.set('n', '<C-right>', '1<C-w><', { noremap = true, silent = true, desc = 'Horizontally resize windows (-)' })

-- Clear search
vim.keymap.set('n', '<leader>h', '<cmd>set hlsearch!<CR>', { noremap = true, silent = true, desc = 'Toggle search highlight' })

-- Macros
vim.keymap.set('n', 'Q', '@q', { desc = 'Plays macro at q' })
vim.keymap.set('x', 'Q', ':norm @q<CR>', { desc = 'Plays macro at q on each lines selected' })

-- Terminal
vim.keymap.set('n', '<leader>x', '<cmd>split | term<CR>', { noremap = true, silent = true, desc = 'Toggle split terminal' })
vim.keymap.set('n', '<leader>X', '<cmd>vsplit | term<CR>', { noremap = true, silent = true, desc = 'Toggle split terminal [vertcal]' })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Unfocus terminal' })

-- Visual Maps
vim.keymap.set("v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>", { desc = 'Replace all instances of highlighted words' })
vim.keymap.set("v", "<C-s>", "<cmd>sort<CR>", { desc = 'Sort highlighted text' })
vim.keymap.set("v", "J", "<cmd>m '>+1<CR>gv=gv", { desc = 'Move current line down' })
-- FIX: Multi line select not moving (need to know how many lines are selected to make the move: m '>[+-]{number_of_lines+1})
vim.keymap.set("v", "K", "<cmd>m '>-2<CR>gv=gv", { desc = 'Move current line up' })

-- Ansible support
vim.filetype.add({
  extension = {
    yml = 'yaml.ansible'
  }
})
