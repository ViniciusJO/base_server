vim.opt.termguicolors = true
vim.cmd.colorscheme("unokai")

local function set_transparent() -- set UI component to transparent
	local groups = {
		"Normal",
		"NormalNC",
		"EndOfBuffer",
		"NormalFloat",
		"FloatBorder",
		"SignColumn",
		"StatusLine",
		"StatusLineNC",
		"TabLine",
		"TabLineFill",
		"TabLineSel",
		"ColorColumn",
	}
	for _, g in ipairs(groups) do
		vim.api.nvim_set_hl(0, g, { bg = "none" })
	end
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
end

set_transparent()

-- ============================================================================
-- OPTIONS
-- ============================================================================
vim.opt.runtimepath:remove(vim.fn.stdpath('config') .. '/autoload/netrw.vim')
vim.opt.runtimepath:remove(vim.fn.stdpath('config') .. '/plugin/netrwPlugin.vim')
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3

vim.opt.number = true -- line number
vim.opt.relativenumber = true -- relative line numbers
vim.opt.cursorline =  true -- highlight current line
vim.opt.wrap = false -- do not wrap lines by default
vim.opt.breakindent = true -- breakindent
vim.opt.scrolloff = 2 -- keep 10 lines above/below cursor
vim.opt.sidescrolloff = 10 -- keep 10 lines to left/right of cursor

vim.opt.tabstop = 2 -- tabwidth
vim.opt.shiftwidth = 2 -- indent width
vim.opt.softtabstop = 2 -- soft tab stop not tabs on tab/backspace
vim.opt.smarttab = true -- smarttab
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true -- copy indent from current line

vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensitive if uppercase in string
vim.opt.hlsearch = true -- highlight search matches
vim.opt.incsearch = true -- show matches as you type

vim.opt.signcolumn = "yes" -- always show a sign column
vim.opt.colorcolumn = "100" -- show a column at 100 position chars
vim.opt.showmatch = true -- highlights matching brackets
vim.opt.cmdheight = 1 -- single line command line
vim.opt.completeopt = "menuone,noinsert,noselect,preview" -- completion options
vim.opt.showmode = false -- do not show the mode, instead have it in statusline
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popup menu transparency
vim.opt.winblend = 0 -- floating window transparency
vim.opt.conceallevel = 0 -- do not hide markup
vim.opt.concealcursor = "" -- do not hide cursorline in markup
vim.opt.lazyredraw = true -- do not redraw during macros
vim.opt.synmaxcol = 300 -- syntax highlighting limit
vim.opt.fillchars = { eob = " " } -- hide "~" on empty lines

local undodir = vim.fn.expand("~/.vim/undodir")
if
	vim.fn.isdirectory(undodir) == 0 -- create undodir if nonexistent
then
	vim.fn.mkdir(undodir, "p")
end

vim.opt.backup = false -- do not create a backup file
vim.opt.writebackup = false -- do not write to a backup file
vim.opt.swapfile = false -- do not create a swapfile
vim.opt.undofile = true -- do create an undo file
vim.opt.undodir = undodir -- set the undo directory
vim.opt.updatetime = 250 -- faster completion
vim.o.timeout = true
vim.opt.timeoutlen = 300 -- timeout duration
vim.opt.ttimeoutlen = 0 -- key code timeout
vim.opt.autoread = true -- auto-reload changes if outside of neovim
vim.opt.autowrite = false -- do not auto-save

vim.opt.hidden = true -- allow hidden buffers
vim.opt.errorbells = false -- no error sounds
vim.opt.backspace = "indent,eol,start" -- better backspace behaviour
vim.opt.autochdir = false -- do not autochange directories
vim.opt.iskeyword:append("-") -- include - in words
vim.opt.path:append("**") -- include subdirs in search
vim.opt.selection = "inclusive" -- include last char in selection
vim.opt.mouse = "a" -- enable mouse support
vim.opt.clipboard:append("unnamedplus") -- use system clipboard
vim.opt.modifiable = true -- allow buffer modifications
vim.opt.encoding = "utf-8" -- set encoding

-- vim.opt.guicursor =
-- 	"n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175" -- cursor blinking and settings

-- Folding: requires treesitter available at runtime; safe fallback if not
vim.opt.foldmethod = "expr" -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.foldlevel = 99 -- start with all folds open

vim.opt.splitbelow = true -- horizontal splits go below
vim.opt.splitright = true -- vertical splits go right

vim.opt.wildmenu = true -- tab completion
vim.opt.wildmode = "longest:full,full" -- complete longest common match, full completion list, cycle through with Tab
vim.opt.diffopt:append("linematch:60") -- improve diff display
vim.opt.redrawtime = 10000 -- increase neovim redraw tolerance
vim.opt.maxmempattern = 20000 -- increase max memory







-- ============================================================================
-- KEYMAPS
-- ============================================================================
vim.g.mapleader = " " -- space for leader
vim.g.maplocalleader = " " -- space for localleader

-- Source configs
vim.keymap.set('n', '<leader>r', '<cmd>source ~/.config/nvim-lite/init.lua<CR>', { desc = 'Source configs' })

-- jj go to normal mode
vim.keymap.set({ 'i' }, 'jj', '<esc>')
vim.keymap.set({ 't', 'c' }, 'jj', '<C-\\><C-n>')

-- Keymaps for save and quit
vim.keymap.set('n', '<C-s>', '<cmd>w<cr>', { desc = 'Save buffer to file', silent = true })
vim.keymap.set('n', '<C-q>', '<cmd>q<cr>', { desc = 'Quit window', silent = true })
vim.keymap.set('n', '<C-Q>', '<cmd>q!<cr>', { desc = 'Quit window', silent = true })

-- Copy to systems clipboard
vim.keymap.set('n', 'Y', '"+y', { desc = 'Yank to systems clipboard' });
vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Yank to systems clipboard' });

-- Go to help
vim.keymap.set('n', 'gh', function() vim.cmd('h ' .. vim.fn.expand('<cword>')) end, { desc = 'Goto help', noremap = true, silent = true })

local arrow_state = false
vim.keymap.set({ 'n', 't', 'i', 'v' }, '<M-A>', function ()
  vim.keymap.set({ 'n', 't', 'i', 'v' }, '<Up>', arrow_state and '<Nop>' or '<Up>', { silent = true})
  vim.keymap.set({ 'n', 't', 'i', 'v' }, '<Down>', arrow_state and '<Nop>' or '<Down>', { silent = true})
  vim.keymap.set({ 'n', 't', 'i', 'v' }, '<Left>', arrow_state and '<Nop>' or '<Left>', { silent = true})
  vim.keymap.set({ 'n', 't', 'i', 'v' }, '<Right>', arrow_state and '<Nop>' or '<Right>', { silent = true})
  arrow_state = not arrow_state
end, { desc = 'Toggle arrow keys', noremap = true, silent = true})

-- better movement in wrapped text
vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

-- Movement on insert mode
vim.keymap.set({ 'i', 't' }, '<C-k>', '<Up>', { noremap = true, silent = true })
vim.keymap.set({ 'i', 't' }, '<C-j>', '<Down>', { noremap = true, silent = true })
vim.keymap.set({ 'i', 't' }, '<C-h>', '<Left>', { noremap = true, silent = true })
vim.keymap.set({ 'i', 't' }, '<C-l>', '<Right>', { noremap = true, silent = true })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

vim.keymap.set('n', '<leader>h', '<cmd>set hlsearch!<CR>', { noremap = true, silent = true, desc = 'Toggle search highlight' })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
-- vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })


vim.keymap.set("n", "<C-J>", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Toggle options
vim.keymap.set('n', '<M-z>', function() if(vim.o.wrap) then vim.o.wrap = false else vim.o.wrap = true end end, {desc = 'Toggle wrap', expr = true})
vim.keymap.set('n', '<M-r>', function() if(vim.o.relativenumber) then vim.o.relativenumber = false else vim.o.relativenumber = true end end, {desc = 'Toggle relative collumn number', expr = true})

-- Tabs
vim.keymap.set('n', '[t', '<CMD>tabnext<CR>', { desc = 'Go to previous tab' })
vim.keymap.set('n', '[T', '<CMD>tablast<CR>', { desc = 'Go to last tab' })
vim.keymap.set('n', ']t', '<CMD>tabprev<CR>', { desc = 'Go to previous tab' })
vim.keymap.set('n', ']T', '<CMD>tabfirst<CR>', { desc = 'Go to first tab' })
vim.keymap.set('n', '<leader>tn', '<CMD>tabnew<CR>', { desc = 'Tab new' })
vim.keymap.set('n', '<leader>td', '<CMD>tabclose<CR>', { desc = 'Tab close' })

-- Buffers
-- vim.keymap.set('n', '<leader>bd', '<CMD>bd<CR>', { desc = 'Close Current Buffer', silent = true })
vim.keymap.set('n', '<leader>bn', '<CMD>enew<CR>', { desc = 'Open Blank Buffer', silent = true })

-- Diagnostic
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set("n", "<leader>le", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

-- Macros
vim.keymap.set('n', 'Q', '@q', { desc = 'Plays macro at q' })
vim.keymap.set('x', 'Q', ':norm @q<CR>', { desc = 'Plays macro at q on each lines selected' })

-- Terminal
vim.keymap.set('n', '<leader>x', '<cmd>split | term<CR>i', { noremap = true, silent = true, desc = 'Toggle split terminal' })
vim.keymap.set('n', '<leader>X', '<cmd>vsplit | term<CR>i', { noremap = true, silent = true, desc = 'Toggle split terminal [vertcal]' })
vim.keymap.set('t', '<esc><esc>', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Unfocus terminal' })
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>', { noremap = true, silent = true, desc = 'Navigate' })

-- Visual Maps
vim.keymap.set("v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>", { desc = 'Replace all instances of highlighted words' })
vim.keymap.set("v", "<C-s>", "<cmd>sort<CR>", { desc = 'Sort highlighted text' })

-- Quickfix
vim.keymap.set({ 'n', 'v', 't' }, "<leader>q",  function()
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      vim.cmd("cclose")
      return
    end
  end
  vim.cmd("cw")
end, { desc = "Toggle quickfix list" })


-- vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
-- vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

-- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
-- vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })


-- vim.keymap.set("n", "<leader>pa", function() -- show file path
-- 	local path = vim.fn.expand("%:p")
-- 	vim.fn.setreg("+", path)
-- 	print("file:", path)
-- end, { desc = "Copy full file path" })



-- ============================================================================
-- AUTOCMDS
-- ============================================================================

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- return to last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	desc = "Restore last cursor position",
	callback = function()
		if vim.o.diff then -- except in diff mode
			return
		end

		local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
		local last_line = vim.api.nvim_buf_line_count(0)

		local row = last_pos[1]
		if row < 1 or row > last_line then
			return
		end

		pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
	end,
})

-- wrap, linebreak and spellcheck on markdown and text files
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
	end,
})

-- Makes terminal in insert mode on win enter
vim.api.nvim_create_autocmd("WinEnter", {
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("startinsert")
    end
  end,
})



-- -- Format on save (ONLY real file buffers, ONLY when efm is attached)
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	group = augroup,
-- 	pattern = {
-- 		"*.lua",
-- 		"*.py",
-- 		"*.go",
-- 		"*.js",
-- 		"*.jsx",
-- 		"*.ts",
-- 		"*.tsx",
-- 		"*.json",
-- 		"*.css",
-- 		"*.scss",
-- 		"*.html",
-- 		"*.sh",
-- 		"*.bash",
-- 		"*.zsh",
-- 		"*.c",
-- 		"*.cpp",
-- 		"*.h",
-- 		"*.hpp",
-- 	},
-- 	callback = function(args)
-- 		-- avoid formatting non-file buffers (helps prevent weird write prompts)
-- 		if vim.bo[args.buf].buftype ~= "" then
-- 			return
-- 		end
-- 		if not vim.bo[args.buf].modifiable then
-- 			return
-- 		end
-- 		if vim.api.nvim_buf_get_name(args.buf) == "" then
-- 			return
-- 		end
--
-- 		local has_efm = false
-- 		for _, c in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
-- 			if c.name == "efm" then
-- 				has_efm = true
-- 				break
-- 			end
-- 		end
-- 		if not has_efm then
-- 			return
-- 		end
--
-- 		pcall(vim.lsp.buf.format, {
-- 			bufnr = args.buf,
-- 			timeout_ms = 2000,
-- 			filter = function(c)
-- 				return c.name == "efm"
-- 			end,
-- 		})
-- 	end,
-- })





-- ============================================================================
-- PLUGINS (vim.pack)
-- ============================================================================
vim.pack.add({
	"https://www.github.com/folke/lazydev.nvim",
	"https://www.github.com/lewis6991/gitsigns.nvim",
	"https://www.github.com/echasnovski/mini.nvim",
	"https://www.github.com/ibhagwan/fzf-lua",
	"https://www.github.com/A7Lavinraj/fyler.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},
	"https://github.com/L3MON4D3/LuaSnip",
	-- Language Server Protocols
	"https://www.github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/creativenull/efmls-configs-nvim",

	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/hrsh7th/cmp-calc",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/hrsh7th/cmp-cmdline",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/saadparwaiz1/cmp_luasnip",

	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("1.*"),
	},
	"https://github.com/ziglang/zig.vim",
	"https://github.com/folke/which-key.nvim",
})

local function packadd(name)
	vim.cmd("packadd " .. name)
end
packadd("lazydev.nvim")
packadd("nvim-treesitter")
packadd("gitsigns.nvim")
packadd("mini.nvim")
packadd("fzf-lua")
packadd("fyler.nvim")
-- LSP
packadd("nvim-lspconfig")
packadd("mason.nvim")
packadd("cmp-nvim-lsp")
packadd("efmls-configs-nvim")
packadd("LuaSnip")
packadd("zig.vim")


-- ============================================================================
-- PLUGIN CONFIGS
-- ============================================================================

local setup_treesitter = function()
	local treesitter = require("nvim-treesitter")
	treesitter.setup({})
	local ensure_installed = {
		"vim", "vimdoc",
		"lua", "luadoc",
    "asm", "nasm",
    'vhdl', 'systemverilog',
		"c", "cpp", "zig",
		"go", "rust",
    "llvm",
    "make",
		"markdown", 'markdown_inline',
		"html", "css",
		"javascript", "json",
		"typescript", "vue", "svelte",
		"bash", "zsh", "awk",
    'matlab',
		"python",
    "ini", "yaml", "xml", "csv", 'properties', 'proto', 'query', 'regex',
    "http", 'nginx',
    "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
    'pem',
    'tmux',
    'udev', 'devicetree'
	}

	local config = require("nvim-treesitter.config")

	local already_installed = config.get_installed()
	local parsers_to_install = {}

	for _, parser in ipairs(ensure_installed) do
		if not vim.tbl_contains(already_installed, parser) then
			table.insert(parsers_to_install, parser)
		end
	end

	-- if #parsers_to_install > 0 then
	-- 	treesitter.install(parsers_to_install)
	-- end

	local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		callback = function(args)
			if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
				vim.treesitter.start(args.buf)
			end
		end,
	})
end

setup_treesitter()

local fyler = require("fyler");
fyler.setup({
  integrations = { icon = "nvim_web_devicons", },
  views = {
    finder = {
      close_on_select = true,
      confirm_simple = false,
      default_explorer = true,
      delete_to_trash = true,
      columns = {
        git = {
          enabled = true,
          symbols = {
            Untracked = "?",
            Added = "+",
            Modified = "*",
            Deleted = "x",
            Renamed = ">",
            Copied = "~",
            Conflict = "!",
            Ignored = "#",
          },
        },
      },
      icon = {
        directory_collapsed = nil,
        directory_empty = nil,
        directory_expanded = nil,
      },
      indentscope = {
        enabled = true,
        group = "FylerIndentMarker",
        markers = "│",
      },
      mappings = {
        ["q"] = "CloseView",
        ["<CR>"] = "Select",
        ["<C-t>"] = "SelectTab",
        ["|"] = "SelectVSplit",
        ["-"] = "SelectSplit",
        ["^"] = "GotoParent",
        ["="] = "GotoCwd",
        ["."] = "GotoNode",
        ["#"] = "CollapseAll",
        ["<BS>"] = "CollapseNode",
      },
      mappings_opts = {
        nowait = false,
        noremap = true,
        silent = true,
      },
      follow_current_file = true,
      watcher = { enabled = false, },
      win = {
        border = vim.o.winborder == "" and "single" or vim.o.winborder,
        buf_opts = {
          filetype = "fyler",
          syntax = "fyler",
          buflisted = false,
          buftype = "acwrite",
          expandtab = true,
          shiftwidth = 2,
        },
        kind = "replace",
        kinds = {
          float = {
            height = "70%",
            width = "70%",
            top = "10%",
            left = "15%",
          },
          replace = {},
          split_above = { height = "70%", },
          split_above_all = {
            height = "70%",
            win_opts = {
              winfixheight = true,
            },
          },
          split_below = {
            height = "70%",
          },
          split_below_all = {
            height = "70%",
            win_opts = {
              winfixheight = true,
            },
          },
          split_left = {
            width = "30%",
          },
          split_left_most = {
            width = "30%",
            win_opts = { winfixwidth = true, },
          },
          split_right = {
            width = "30%",
          },
          split_right_most = {
            width = "30%",
            win_opts = {
              winfixwidth = true,
            },
          },
        },
        win_opts = {
          concealcursor = "nvic",
          conceallevel = 3,
          cursorline = false,
          number = false,
          relativenumber = false,
          winhighlight = "Normal:FylerNormal,NormalNC:FylerNormalNC",
          wrap = false,
          signcolumn = "yes",
        },
      }
    }
  }
})

local function run_cmd_capture(cmd)
  vim.v.errmsg = ""
  vim.cmd("redir => g:__cmd_output")
  vim.cmd("silent " .. cmd)
  vim.cmd("redir END")

  local out = vim.g.__cmd_output or ""
  vim.g.__cmd_output = nil

  return out, vim.v.errmsg
end

local function is_intro_buffer()
  local name = vim.api.nvim_buf_get_name(0)
  local buftype = vim.bo.buftype
  local line_count = vim.api.nvim_buf_line_count(0)
  local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
  return name == "" and buftype == "" and line_count <= 1 and (first_line == "" or first_line == nil)
end

vim.keymap.set("n", "<leader>e", function()
  if is_intro_buffer() then fyler.toggle({ kind = "replace" });
  elseif vim.bo.filetype ~= "fyler" then fyler.toggle({ kind = "split_left_most" });
  elseif #vim.api.nvim_tabpage_list_wins(0) > 1 then fyler.toggle({ kind = "split_left_most" });
  else run_cmd_capture("intro");
  end
end, { desc = "Open Fyler explorer", silent = true, noremap = true })

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local args = vim.fn.argv()
    local is_dir = (#args == 1) and vim.fn.isdirectory(args[1]) == 1
    if is_dir then
      vim.api.nvim_set_current_dir(args[1])
      fyler.open({ kind = "replace" }) -- Open it with oil.nvim
      vim.bo.buflisted = false;
    end
  end,
})




vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeSignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#2a2a2a", bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })

require("fzf-lua").setup({})

vim.keymap.set("n", "<leader>ff", function() require("fzf-lua").files() end, { desc = "FZF Files" })
vim.keymap.set("n", "<leader>fg", function() require("fzf-lua").live_grep() end, { desc = "FZF Live Grep" })
vim.keymap.set("n", "<leader>fb", function() require("fzf-lua").buffers() end, { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fh", function() require("fzf-lua").help_tags() end, { desc = "FZF Help Tags" })
vim.keymap.set("n", "<leader>fx", function() require("fzf-lua").diagnostics_document() end, { desc = "FZF Diagnostics Document" })
vim.keymap.set("n", "<leader>fX", function() require("fzf-lua").diagnostics_workspace() end, { desc = "FZF Diagnostics Workspace" })

require("mini.ai").setup({})
require("mini.comment").setup({})
require("mini.move").setup({})
require("mini.surround").setup({})
require("mini.cursorword").setup({})
require("mini.indentscope").setup({})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.bufremove").setup({})
require("mini.notify").setup({})
require("mini.icons").setup({})

require("gitsigns").setup({
	signs = {
		add = { text = "\u{2590}" }, -- ▏
		change = { text = "\u{2590}" }, -- ▐
		delete = { text = "\u{2590}" }, -- ◦
		topdelete = { text = "\u{25e6}" }, -- ◦
		changedelete = { text = "\u{25cf}" }, -- ●
		untracked = { text = "\u{25cb}" }, -- ○
	},
	signcolumn = true,
	current_line_blame = false,
})

require("mason").setup()

vim.keymap.set("n", "]h", function() require("gitsigns").next_hunk() end, { desc = "Next git hunk" })
vim.keymap.set("n", "[h", function() require("gitsigns").prev_hunk() end, { desc = "Previous git hunk" })
vim.keymap.set("n", "<leader><leader>hs", function() require("gitsigns").stage_hunk() end, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader><leader>hr", function() require("gitsigns").reset_hunk() end, { desc = "Reset hunk" })
vim.keymap.set("n", "<leader><leader>hp", function() require("gitsigns").preview_hunk() end, { desc = "Preview hunk" })
vim.keymap.set("n", "<leader><leader>hb", function() require("gitsigns").blame_line({ full = true }) end, { desc = "Blame line" })
vim.keymap.set("n", "<leader><leader>hB", function() require("gitsigns").toggle_current_line_blame() end, { desc = "Toggle inline blame" })
vim.keymap.set("n", "<leader><leader>hd", function() require("gitsigns").diffthis() end, { desc = "Diff this" })

vim.g.zig_fmt_autosave = 0

require('which-key').add({{ '<leader>b', desc='Buffer', noremap=true }})
require('which-key').add({{ '<leader>t', desc='Tab', noremap=true }})


-- ============================================================================
-- LSP, Linting, Formatting & Completion
-- ============================================================================

local cmp = require('cmp')
local luasnip = require('luasnip')
luasnip.config.setup({})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
  matching = {
    disallow_symbol_nonprefix_matching = false,
    disallow_fuzzy_matching = false,
    disallow_partial_matching = false,
    disallow_prefix_unmatching = false,
    disallow_fullfuzzy_matching = false,
    disallow_partial_fuzzy_matching = false
  }
})

local kind_icons = { Text = "", Method = "󰆧", Function = "󰊕", Constructor = "", Field = "󰇽", Variable = "󰂡", Class = "󰠱", Interface = "", Module = "", Property = "󰜢", Unit = "", Value = "󰎠", Enum = "", Keyword = "󰌋", Snippet = "", Color = "󰏘", File = "󰈙", Reference = "", Folder = "󰉋", EnumMember = "", Constant = "󰏿", Struct = "", Event = "", Operator = "󰆕", TypeParameter = "󰅲", }

cmp.setup {
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end, },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'path' },
    { name = 'calc' },
    { name = 'nvim_lsp' },
    { name = 'command' },
    { name = 'luasnip' },
    { name = 'buffer' },
  },
  border = { completion = true, documentation = true },
  -- window = {
  --   completion = {
  --     -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  --     border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  --     -- winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
  --   },
  --   documentation = {
  --     border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  --     -- winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
  --   },
  -- },
  formatting = {
    fields = { 'kind', 'abbr' },
    expandable_indicator = true,
    format = function(entry, vim_item)

      vim_item.kind = string.format(' %s %s ', kind_icons[vim_item.kind], vim_item.kind)

      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[LaTeX]",
      })[entry.source.name]


      return vim_item
    end
  },
}

local diagnostic_signs = {
	Error = " ",
	Warn = " ",
	Hint = "",
	Info = "",
}

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
		focusable = false,
		style = "minimal",
	},
})


require("lazydev").setup({
    library = {
      -- It can also be a table with trigger words / mods
      -- Only load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      -- Load the wezterm types when the `wezterm` module is required
      -- Needs `DrKJeff16/wezterm-types` to be installed
      { path = "wezterm-types", mods = { "wezterm" } },
      -- Load the xmake types when opening file named `xmake.lua`
      -- Needs `LelouchHe/xmake-luals-addon` to be installed
      { path = "xmake-luals-addon/library", files = { "xmake.lua" } },
    },
    enabled = function(root_dir)
      local _ = root_dir;
      return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
    end,
  }
)

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

vim.lsp.config["*"] = { capabilities = capabilities, }

do
	local orig = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		return orig(contents, syntax, opts, ...)
	end
end

local function lsp_on_attach(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if not client then
		return
	end

	local bufnr = ev.buf
	local opts = { noremap = true, silent = true, buffer = bufnr }


  local buf = vim.lsp.buf
  local wk = require('which-key');

  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'Type Definition' })

  wk.add({ { '<leader>l', desc = 'LSP' } });
  vim.keymap.set('n', '<leader>lf', buf.format, { desc = 'Format' })
  vim.keymap.set('n', '<leader>lr', buf.rename, { desc = 'Rename' })
  vim.keymap.set('n', '<leader>la', buf.code_action, { desc = 'Code Actions' })

  wk.add({ { '<leader>ls', desc = 'Split horizontaly and...' } });
  wk.add({ { '<leader>lv', desc = 'Split verticaly and...' } });

  vim.keymap.set('n', '<leader>lsd', function()
    vim.cmd("split")
    buf.definition()
  end, { desc = 'Goto Definition' })
  vim.keymap.set('n', '<leader>lvd', function()
    vim.cmd("vsplit")
    buf.definition()
  end, { desc = 'Goto Definition' })

  vim.keymap.set('n', '<leader>lR', ':LspRestart<cr>', { desc = 'Restart LSP' })

  wk.add({ { '<leader>w', desc = 'Workspace' } });
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'Workspace Add Folder' })
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'Workspace Remove Folder' })
  vim.keymap.set('n', '<leader>ww', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
  { desc = 'Workspace List Folders' })

  wk.add({ { '<leader>g', desc = 'Goto' } });

  vim.keymap.set('n', '<leader>gd', buf.definition, { desc = 'Goto Definition' })
  vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration' })
  vim.keymap.set('n', '<leader>gI', buf.implementation, { desc = 'Goto Implementation' })
  vim.keymap.set('n', 'gd', buf.definition, { desc = 'Goto Definition' })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration' })
  vim.keymap.set('n', 'gI', buf.implementation, { desc = 'Goto Implementation' })

  -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
  vim.keymap.set('i', '<C-\\>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })

  -- if client.server_capabilities["documentSymbolProvider"] then
  --   require("nvim-navic").attach(client, bufnr)
  -- end

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })


	vim.keymap.set("n", "<leader>fd", function()
		require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
	end, opts)
	vim.keymap.set("n", "<leader>fr", function()
		require("fzf-lua").lsp_references()
	end, opts)
	vim.keymap.set("n", "<leader>ft", function()
		require("fzf-lua").lsp_typedefs()
	end, opts)
	vim.keymap.set("n", "<leader>fs", function()
		require("fzf-lua").lsp_document_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>fw", function()
		require("fzf-lua").lsp_workspace_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>fi", function()
		require("fzf-lua").lsp_implementations()
	end, opts)

	if client:supports_method("textDocument/codeAction", bufnr) then
		vim.keymap.set("n", "<leader>oi", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" }, diagnostics = {} },
				apply = true,
				bufnr = bufnr,
			})
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50)
		end, opts)
	end
end

vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

-- vim.keymap.set("n", "<leader>dq", function()
-- 	vim.diagnostic.setloclist({ open = true })
-- end, { desc = "Open diagnostic list" })
-- vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

local servers = {
  clangd = {
  -- capabilities = capabilities;
  -- cmd = { "/home/vinicius/.espressif/tools/esp-clang/esp-18.1.2_20240912/esp-clang/bin/clangd", "--background-index", "--query-driver=**", },
  -- root_dir = function()
    --   -- leave empty to stop nvim from cd'ing into ~/ due to global .clangd file
    -- end
    cmd = { "clangd", "--compile-commands-dir=." },
    -- root_dir = require('lspconfig.util').root_pattern('compile_commands.json', '.git'),
  },
  lua_ls = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false }
    }
  },
  ansiblels = {},
  -- ["ansible-lint"] = {},
  arduino_language_server = {},
  -- asm_lsp = {},
  asmfmt = {},
  bashls = {},
  beautysh = {},
  ["buf-language-server"] = {},
  checkmake = {},
  ["clang-format"] = {},
  cmake = {},
  cmakelang = {},
  cmakelint = {},
  codelldb = {},
  cpplint = {},
  cpptools = {},
  cssls = {},
  css_variables = {},
  cssmodules_ls = {},
  ["dart-debug-adapter"] = {},
  dcm = {},
  docker_compose_language_service = {},
  dockerls = {},
  eslint = {},
  eslint_d = {},
  ["firefox-debug-adapter"] = {},
  gitleaks = {},
  gitlint = {},
  gitui = {},
  glow = {},
  glsl_analyzer = {},
  glslls = {},
  html = {},
  htmlbeautifier = {},
  htmlhint = {},
  ["js-debug-adapter"] = {},
  jsonls = {},
  jsonnetfmt = {},
  latexindent = {},
  ltex = {},
  luacheck = {},
  luaformatter = {},
  markdown_oxide = {},
  marksman = {},
  markuplint = {},
  -- ["node-debug2-adapter"] = {},
  prettier = {},
  prettierd = {},
  pyright = {},
  remark_ls = {},
  rust_analyzer = {},
  shellcheck = {},
  -- shellharden = {},
  shfmt = {},
  sqlfmt = {},
  sqls = {},
  svelte = {},
  systemdlint = {},
  taplo = {},
  ["tree-sitter-cli"] = {},
  ["ts-standard"] = {},
  ts_ls = {},
  xmlformatter = {},
  yamlls = {},
  yamlfix = {},
  yamlfmt = {},
  yamllint = {},
  zls = {},
}

for sname, sconfig in pairs(servers) do
  vim.lsp.config(sname, sconfig)
end

-- vim.lsp.config("pyright", {})
-- vim.lsp.config("bashls", {})
-- vim.lsp.config("ts_ls", {})
-- vim.lsp.config("gopls", {})
-- vim.lsp.config("clangd", {})

do
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")

	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")

	local prettier_d = require("efmls-configs.formatters.prettier_d")
	local eslint_d = require("efmls-configs.linters.eslint_d")

	local fixjson = require("efmls-configs.formatters.fixjson")

	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")

	local cpplint = require("efmls-configs.linters.cpplint")
	local clangfmt = require("efmls-configs.formatters.clang_format")

	local go_revive = require("efmls-configs.linters.go_revive")
	local gofumpt = require("efmls-configs.formatters.gofumpt")

	vim.lsp.config("efm", {
		filetypes = {
			"c",
			"cpp",
			"css",
			"go",
			"html",
			"javascript",
			"javascriptreact",
			"json",
			"jsonc",
			"lua",
			"markdown",
			"python",
			"sh",
			"typescript",
			"typescriptreact",
			"vue",
			"svelte",
		},
		init_options = { documentFormatting = true },
		settings = {
			languages = {
				c = { clangfmt, cpplint },
				go = { gofumpt, go_revive },
				cpp = { clangfmt, cpplint },
				css = { prettier_d },
				html = { prettier_d },
				javascript = { eslint_d, prettier_d },
				javascriptreact = { eslint_d, prettier_d },
				json = { eslint_d, fixjson },
				jsonc = { eslint_d, fixjson },
				lua = { luacheck, stylua },
				markdown = { prettier_d },
				python = { flake8, black },
				sh = { shellcheck, shfmt },
				typescript = { eslint_d, prettier_d },
				typescriptreact = { eslint_d, prettier_d },
				vue = { eslint_d, prettier_d },
				svelte = { eslint_d, prettier_d },
			},
		},
	})
end

local function keys(tbl)
  local ks = {}
  for k in pairs(tbl) do table.insert(ks, k) end
  return ks;
end

vim.lsp.enable(keys(servers))



-- ============================================================================
-- FLOATING TERMINAL
-- ============================================================================
vim.api.nvim_create_autocmd("TermClose", {
	group = augroup,
	callback = function()
		if vim.v.event.status == 0 then
			vim.api.nvim_buf_delete(0, {})
		end
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})

local terminal_state = { buf = nil, win = nil, is_open = false }

local function FloatingTerminal()
	if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
		return
	end

	if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
		terminal_state.buf = vim.api.nvim_create_buf(false, true)
		vim.bo[terminal_state.buf].bufhidden = "hide"
	end

	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})

	vim.wo[terminal_state.win].winblend = 0
	vim.wo[terminal_state.win].winhighlight = "Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder"
	vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none" })

	local has_terminal = false
	local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
	for _, line in ipairs(lines) do
		if line ~= "" then
			has_terminal = true
			break
		end
	end
	if not has_terminal then
		vim.fn.termopen(os.getenv("SHELL"))
	end

	terminal_state.is_open = true
	vim.cmd("startinsert")

	vim.api.nvim_create_autocmd("BufLeave", {
		buffer = terminal_state.buf,
		callback = function()
			if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
				vim.api.nvim_win_close(terminal_state.win, false)
				terminal_state.is_open = false
			end
		end,
		once = true,
	})
end

-- TODO: fix terminal_state.is_open update on buff exit
-- vim.keymap.set("n", "<leader>t", FloatingTerminal, { noremap = true, silent = true, desc = "Toggle floating terminal" })
vim.keymap.set({ "n", "t"}, "<M-t>", function()
	if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_hide(terminal_state.win)
		terminal_state.is_open = false
  else
    FloatingTerminal()
	end
end, { noremap = true, silent = true, desc = "Close floating terminal" })


-- ============================================================================
-- STATUSLINE
-- ============================================================================


vim.o.cmdheight = 1
vim.o.showcmd = false
-- vim.o.showcmdloc = "statusline"
vim.o.laststatus = 3
vim.o.ruler = false

local cmdline_content = ""

local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
  ["nt"] = "UNFOCUSED TERMINAL",
}

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(" %s ", modes[current_mode]):upper()
end

local function update_mode_colors()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#StatusLineAccent#"
  if current_mode == "n" then
    mode_color = "%#StatuslineAccent#"
  elseif current_mode == "i" or current_mode == "ic" then
    mode_color = "%#StatuslineInsertAccent#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
    mode_color = "%#StatuslineVisualAccent#"
  elseif current_mode == "R" then
    mode_color = "%#StatuslineReplaceAccent#"
  elseif current_mode == "c" then
    mode_color = "%#StatuslineCmdLineAccent#"
  elseif current_mode == "t" then
    mode_color = "%#StatuslineTerminalAccent#"
  elseif current_mode == "nt" then
    mode_color = "%#StatuslineTerminalAccent#"
  end
  return mode_color
end

-- local function update_mode_colors()
--   local current_mode = vim.api.nvim_get_mode().mode
--   local mode_color = "%#StatusLineAccent#"
--   if current_mode == "n" then
--       mode_color = "%#StatuslineAccent#"
--   elseif current_mode == "i" or current_mode == "ic" then
--       mode_color = "%#StatuslineInsertAccent#"
--   elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
--       mode_color = "%#StatuslineVisualAccent#"
--   elseif current_mode == "R" then
--       mode_color = "%#StatuslineReplaceAccent#"
--   elseif current_mode == "c" then
--       mode_color = "%#StatuslineCmdLineAccent#"
--   elseif current_mode == "t" then
--       mode_color = "%#StatuslineTerminalAccent#"
--   end
--   return mode_color
-- end

local function filepath()
  if cmdline_content == "" then
    local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
    if fpath == "" or fpath == "." then
      return " "
    end

    return string.format(" %%<%s/", fpath)
  else
    return ""
  end
end

local function filename()
  if cmdline_content == "" then
    local fname = vim.fn.expand "%:t"
    if fname == "" then
      return ""
    end
    return fname .. " %m "
  else
    return ""
  end
end

-- Function to execute shell commands
local function execute(command)
  local handle = io.popen(command)
  if not handle then error("Command "..string(command).." error", 1) end
  local result = handle:read("*a")
  handle:close()
  return result
end

-- Function to get the current Git branch
local function git_branch()
  if cmdline_content == "" then
    local branch = execute(string.format("git -C %s rev-parse --abbrev-ref HEAD 2> /dev/null || echo ''",
      vim.fn.expand("%:h")))
    return branch:gsub("^%s*(.-)%s*$", "%1") == "" and "" or branch:gsub("^%s*(.-)%s*$", "<< %1>>") -- Trim whitespace
  else
    return ""
  end
end

local function lsp()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = " %#LspDiagnosticsSignError# " .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
  end
  if count["hints"] ~= 0 then
    hints = " %#LspDiagnosticsSignHint# " .. count["hints"]
  end
  if count["info"] ~= 0 then
    info = " %#LspDiagnosticsSignInformation# " .. count["info"]
  end

  return errors .. warnings .. hints .. info .. "%#Normal#"
end

local function filetype()
  local icon, color = require('nvim-web-devicons').get_icon_color(filename(), vim.bo.filetype)
  -- local icon = nil
  -- local color = "#FF0000"
  vim.api.nvim_set_hl(0, 'StatusLineFileType', { foreground = color, background = 'none', bold = false })

  return string.format(" %%#StatusLineFileType#%s %s %%#Normal#", icon or "", vim.bo.filetype) --:upper()
end

local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " %P %4.l:%3.c "
end

-- local function commandstr()
--   if cmdline_content ~= "" then
--     return " " .. cmdline_content
--   else
--     return ""
--   end
-- end

Statusline = {}

Statusline.active = function()
  return table.concat {
    "%#Statusline#",
    update_mode_colors(),
    mode(),
    "%#Normal#",
    -- cmdline_content == "" and filepath() .. filename() or " " .. cmdline_content,
    vim.api.nvim_get_mode().mode == "c" and (" ".. vim.fn.getcmdtype() .. (cmdline_content .. " ")) or filepath() .. filename(),
    -- vim.api.nvim_get_mode().mode == "c" and (" ".. vim.fn.getcmdtype() .. require("my_ui").place_cursor(cmdline_content .. " ")) or filepath() .. filename(),
    -- vim.api.nvim_get_mode().mode,
    -- "%#Directory# ",
    "%=%#WarningMsg#",
    git_branch(),
    "%=%#Normal#",
    lsp(),
    " ",
    filetype(),
    "%#StatusLineExtra#",
    lineinfo(),
  }
end

function Statusline.inactive()
  return " %F"
end

function Statusline.short()
  return "%#StatusLineNC#   NvimTree"
end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)

-- vim.o.statusline = "%t%M %S%=%y %(%L lines %l:%c [%3.p%%]%)"

--statusline
-- vim.api.nvim_set_hl(0, 'StatusType',{ foreground='#1d2021', background='#b16286', bold=false })
-- vim.api.nvim_set_hl(0, 'StatusFile',{ foreground='#1d2021', background='#fabd2f', bold=false })
-- vim.api.nvim_set_hl(0, 'StatusModified',{ foreground='#d3869b', background='#1d2021', bold=false })
-- vim.api.nvim_set_hl(0, 'StatusBuffer',{ foreground='#1d2021', background='#98971a', bold=false })
-- vim.api.nvim_set_hl(0, 'StatusLocation',{ foreground='#1d2021', background='#458588', bold=false })
-- vim.api.nvim_set_hl(0, 'StatusPercent',{ foreground='#ebdbb2', background='#1d2021', bold=false })
-- vim.api.nvim_set_hl(0, 'StatusNorm',{ foreground='#FFFFFF', background='none', bold=false })
vim.api.nvim_set_hl(0, 'StatusType', { foreground = '#1d2021', background = '#b16286', bold = false })
vim.api.nvim_set_hl(0, 'StatusFile', { foreground = '#1d2021', background = '#fabd2f', bold = false })
vim.api.nvim_set_hl(0, 'StatusModified', { foreground = '#d3869b', background = '#1d2021', bold = false })
vim.api.nvim_set_hl(0, 'StatusBuffer', { foreground = '#1d2021', background = '#98971a', bold = false })
vim.api.nvim_set_hl(0, 'StatusLocation', { foreground = '#1d2021', background = '#458588', bold = false })
vim.api.nvim_set_hl(0, 'StatusPercent', { foreground = '#ebdbb2', background = '#1d2021', bold = false })
vim.api.nvim_set_hl(0, 'StatusNorm', { foreground = '#FFFFFF', background = 'none', bold = false })

local function getColor(group)
  return vim.api.nvim_get_hl_by_name(group, true)
end

vim.api.nvim_set_hl(0, 'StatusLineAccent', { foreground = '#000000', background = '#FFFFFF', bold = false })
vim.api.nvim_set_hl(0, 'StatuslineAccent',
  { foreground = '#000000', background = getColor('IncSearch').background, bold = false })
vim.api.nvim_set_hl(0, 'StatuslineInsertAccent',
  { foreground = '#000000', background = getColor('WarningMsg').foreground, bold = false })
vim.api.nvim_set_hl(0, 'StatuslineVisualAccent', getColor('Substitute'))
vim.api.nvim_set_hl(0, 'StatuslineCmdLineAccent', getColor('WildMenu'))
vim.api.nvim_set_hl(0, 'StatuslineTerminalAccent', getColor('DiffChange'))
vim.api.nvim_set_hl(0, 'StatuslineReplaceAccent', getColor('DiffText'))

-- vim.api.nvim_set_hl(0, 'StatusLineAccent',{ foreground='#000000', background='#FFFFFF', bold=false })
-- vim.api.nvim_set_hl(0, 'StatuslineAccent',{ foreground='#000000', background='#33bb77', bold=false })
-- vim.api.nvim_set_hl(0, 'StatuslineInsertAccent',{ foreground='#000000', background='#00AF21', bold=false })
-- vim.api.nvim_set_hl(0, 'StatuslineVisualAccent',{ foreground='#000000', background='#FF4321', bold=false })
-- vim.api.nvim_set_hl(0, 'StatuslineReplaceAccent',{ foreground='#000000', background='#FFFFFF', bold=false })
-- vim.api.nvim_set_hl(0, 'StatuslineCmdLineAccent',{ foreground='#000000', background='#3377EB', bold=false })
-- vim.api.nvim_set_hl(0, 'StatuslineTerminalAccent',{ foreground='#000000', background='#1274AF', bold=false })

vim.api.nvim_set_hl(0, 'StatusGit', { foreground = '#AA23FF', background = 'none', bold = false })

vim.api.nvim_set_hl(0, 'LspDiagnosticsSignError', { foreground = '#FF4321', background = 'none', bold = false })
vim.api.nvim_set_hl(0, 'LspDiagnosticsSignWarning', { foreground = '#AA8710', background = 'none', bold = false })
vim.api.nvim_set_hl(0, 'LspDiagnosticsSignHint', { foreground = '#1274AF', background = 'none', bold = false })
vim.api.nvim_set_hl(0, 'LspDiagnosticsSignInformation', { foreground = '#00AF21', background = 'none', bold = false })


-- Autocommand for when command line is entered
vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
  callback = function()
    vim.cmd.redrawstatus()
  end,
})

-- Autocommand for when command line is changed
vim.api.nvim_create_autocmd({ "CmdlineChanged" }, {
  callback = function()
    cmdline_content = vim.fn.getcmdline()
    vim.cmd.redrawstatus()
  end,
})

-- Autocommand for when command line is exited
vim.api.nvim_create_autocmd({ "CmdlineLeave" }, {
  callback = function()
    cmdline_content = ""
    vim.cmd.redrawstatus()
  end,
})















-- Git branch function with caching and Nerd Font icon
-- local cached_branch = ""
-- local last_check = 0
-- local function git_branch()
-- 	local now = vim.loop.now()
-- 	if now - last_check > 5000 then -- Check every 5 seconds
-- 		cached_branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
-- 		last_check = now
-- 	end
-- 	if cached_branch ~= "" then
-- 		return " \u{e725} " .. cached_branch .. " " -- nf-dev-git_branch
-- 	end
-- 	return ""
-- end
--
-- -- File type with Nerd Font icon
-- local function file_type()
-- 	local ft = vim.bo.filetype
-- 	local icons = {
-- 		lua = "\u{e620} ", -- nf-dev-lua
-- 		python = "\u{e73c} ", -- nf-dev-python
-- 		javascript = "\u{e74e} ", -- nf-dev-javascript
-- 		typescript = "\u{e628} ", -- nf-dev-typescript
-- 		javascriptreact = "\u{e7ba} ",
-- 		typescriptreact = "\u{e7ba} ",
-- 		html = "\u{e736} ", -- nf-dev-html5
-- 		css = "\u{e749} ", -- nf-dev-css3
-- 		scss = "\u{e749} ",
-- 		json = "\u{e60b} ", -- nf-dev-json
-- 		markdown = "\u{e73e} ", -- nf-dev-markdown
-- 		vim = "\u{e62b} ", -- nf-dev-vim
-- 		sh = "\u{f489} ", -- nf-oct-terminal
-- 		bash = "\u{f489} ",
-- 		zsh = "\u{f489} ",
-- 		rust = "\u{e7a8} ", -- nf-dev-rust
-- 		go = "\u{e724} ", -- nf-dev-go
-- 		c = "\u{e61e} ", -- nf-dev-c
-- 		cpp = "\u{e61d} ", -- nf-dev-cplusplus
-- 		java = "\u{e738} ", -- nf-dev-java
-- 		php = "\u{e73d} ", -- nf-dev-php
-- 		ruby = "\u{e739} ", -- nf-dev-ruby
-- 		swift = "\u{e755} ", -- nf-dev-swift
-- 		kotlin = "\u{e634} ",
-- 		dart = "\u{e798} ",
-- 		elixir = "\u{e62d} ",
-- 		haskell = "\u{e777} ",
-- 		sql = "\u{e706} ",
-- 		yaml = "\u{f481} ",
-- 		toml = "\u{e615} ",
-- 		xml = "\u{f05c} ",
-- 		dockerfile = "\u{f308} ", -- nf-linux-docker
-- 		gitcommit = "\u{f418} ", -- nf-oct-git_commit
-- 		gitconfig = "\u{f1d3} ", -- nf-fa-git
-- 		vue = "\u{fd42} ", -- nf-md-vuejs
-- 		svelte = "\u{e697} ",
-- 		astro = "\u{e628} ",
-- 	}
--
-- 	if ft == "" then
-- 		return " \u{f15b} " -- nf-fa-file_o
-- 	end
--
-- 	return ((icons[ft] or " \u{f15b} ") .. ft)
-- end
--
-- -- File size with Nerd Font icon
-- local function file_size()
-- 	local size = vim.fn.getfsize(vim.fn.expand("%"))
-- 	if size < 0 then
-- 		return ""
-- 	end
-- 	local size_str
-- 	if size < 1024 then
-- 		size_str = size .. "B"
-- 	elseif size < 1024 * 1024 then
-- 		size_str = string.format("%.1fK", size / 1024)
-- 	else
-- 		size_str = string.format("%.1fM", size / 1024 / 1024)
-- 	end
-- 	return " \u{f016} " .. size_str .. " " -- nf-fa-file_o
-- end
--
-- -- Mode indicators with Nerd Font icons
-- local function mode_icon()
-- 	local mode = vim.fn.mode()
-- 	local modes = {
-- 		n = " \u{f121}  NORMAL",
-- 		i = " \u{f11c}  INSERT",
-- 		v = " \u{f0168} VISUAL",
-- 		V = " \u{f0168} V-LINE",
-- 		["\22"] = " \u{f0168} V-BLOCK",
-- 		c = " \u{f120} COMMAND",
-- 		s = " \u{f0c5} SELECT",
-- 		S = " \u{f0c5} S-LINE",
-- 		["\19"] = " \u{f0c5} S-BLOCK",
-- 		R = " \u{f044} REPLACE",
-- 		r = " \u{f044} REPLACE",
-- 		["!"] = " \u{f489} SHELL",
-- 		t = " \u{f120} TERMINAL",
-- 	}
-- 	return modes[mode] or (" \u{f059} " .. mode)
-- end
--
-- _G.mode_icon = mode_icon
-- _G.git_branch = git_branch
-- _G.file_type = file_type
-- _G.file_size = file_size
--
-- vim.cmd([[
--   highlight StatusLineBold gui=bold cterm=bold
-- ]])
--
-- -- Function to change statusline based on window focus
-- local function setup_dynamic_statusline()
-- 	vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
-- 		callback = function()
-- 			vim.opt_local.statusline = table.concat({
-- 				"  ",
-- 				"%#StatusLineBold#",
-- 				"%{v:lua.mode_icon()}",
-- 				"%#StatusLine#",
-- 				" \u{e0b1} %f %h%m%r", -- nf-pl-left_hard_divider
-- 				"%{v:lua.git_branch()}",
-- 				"\u{e0b1} ", -- nf-pl-left_hard_divider
-- 				"%{v:lua.file_type()}",
-- 				"\u{e0b1} ", -- nf-pl-left_hard_divider
-- 				"%{v:lua.file_size()}",
-- 				"%=", -- Right-align everything after this
-- 				" \u{f017} %l:%c  %P ", -- nf-fa-clock_o for line/col
-- 			})
-- 		end,
-- 	})
-- 	vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })
--
-- 	vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
-- 		callback = function()
-- 			vim.opt_local.statusline = "  %f %h%m%r \u{e0b1} %{v:lua.file_type()} %=  %l:%c   %P "
-- 		end,
-- 	})
-- end
--
-- setup_dynamic_statusline()
--


-- ============================================================================
-- CMD EXECUTION
-- ============================================================================


local function append_multiline(lines, position)
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(buf, position, position, false, lines)
end

local function append_multiline_indent(lines, position, indent)
  local padding = ""
  for _ = 1, indent, 1 do padding = padding .. " " end

  local indented_lines = {}
  for _, line in ipairs(lines) do
    table.insert(indented_lines, padding .. line)
  end

  append_multiline(indented_lines, position)
end

local function remove_line_from_buffer(line_number)
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(buf, line_number - 1, line_number, false, {})
end

local function count_leading_spaces(str)
  local count = 0
  for i = 1, #str do
    if str:sub(i, i) == " " then
      count = count + 1
    else
      break
    end
  end
  return count
end

-- local function get_comment_marker(filetype)
--   local clients = vim.lsp.get_active_clients()
--
--   for _, client in ipairs(clients) do
--     if client.supports_method("textDocument/completion") then
--       local comment_marker = client.resolved_capabilities.document_formatting
--       if comment_marker and comment_marker[filetype] then
--         return comment_marker[filetype]
--       end
--     end
--   end
--
--   return nil   -- Return nil if no comment marker is found
-- end


-- TODO:
--    - Remove comment markers to allow to execute commands inside comments (lsp integration)
--    - Highlight with treesitter the commands inside comments
local function executeCommandInBuffer(replace)
  return function()
    local linen = vim.fn.line('.')
    local line_content = vim.fn.getline(linen)

    local command = line_content:gsub("^%s*", "")
    if nil == command:find("^:") and nil == command:find("^!") then
      vim.notify('\"' .. command .. '\" is not a valid command', vim.log.levels.ERROR)
      return
    end
    local result = vim.api.nvim_exec2(command, { output = true }).output
        :gsub("\0", "")
        :gsub(string.char(10), "\r")
        :gsub("%z", "")
        :gsub("^:*" .. command:gsub("^:", ""), "")
    local lines = vim.split(result, "\r")

    if lines[1] == command:gsub("^!", ":!") then table.remove(lines, 1) end
    while '' == lines[1] do table.remove(lines, 1) end
    if lines[#lines] == "" then table.remove(lines, #lines) end

    append_multiline_indent(lines, linen, count_leading_spaces(line_content))
    if replace then
      remove_line_from_buffer(linen)
    end
  end
end

vim.keymap.set({ 'n' }, '<M-X>', executeCommandInBuffer(false), { desc = 'Execute command in place' })
vim.keymap.set({ 'n' }, '<M-x>', executeCommandInBuffer(true), { desc = 'Execute command in place and replace' })

local function print_char_code()
  local line_number = vim.fn.line('.')
  local column_number = vim.fn.col('.')

  local line_content = vim.fn.getline(line_number)
  local char = line_content:sub(column_number, column_number)
  local char_code = string.byte(char)
  print("Character code: '" .. char .. "' = " .. char_code)
end

vim.keymap.set('n', '<leader>A', print_char_code, { desc = 'Code of char under cursor', noremap = true, silent = true })

local function preprocessCFile()
  local current_file = vim.fn.expand('%:p')

  if not current_file:match('%.c$') and not current_file:match('%.h$') then
    print("Not a C or header file")
    return
  end

  vim.notify("Preprocessing...", vim.log.levels.INFO, { title = "PreprocessCFile" })
  local output = vim.fn.system("make --quiet preprocess filename=" ..
    current_file .. ' 2>&1 | grep --invert-match "^#" | clang-format | sed \'/./,/^$/!d; /^$/N;/\\n$/D\'')

  vim.cmd('new')        -- Open a new buffer
  vim.bo.filetype = 'c' -- Set filetype to C
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(output, "\n"))
  vim.cmd('setlocal buftype=nofile') -- Set buffer as not a file
end

vim.api.nvim_create_user_command('PreprocessC', preprocessCFile, {})
vim.keymap.set('n', '<leader>lp', preprocessCFile, { desc = 'Preprocess C File' })

