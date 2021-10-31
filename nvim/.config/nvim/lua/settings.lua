-- NVIM Settings

local cmd = vim.cmd
local exec = vim.api.nvim_exec
local eval = vim.api.nvim_eval
local fn = vim.fn
local g = vim.g
local opt = vim.opt

g.mapleader = ' '
opt.mouse = '' -- Mouse is for the WEAK
opt.clipboard = 'unnamedplus'

opt.errorbells = false
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.wrap = false
opt.smartcase = true
opt.swapfile = false
opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
opt.undofile = true
opt.number = true
opt.relativenumber = true
opt.backup = false
opt.incsearch = true
opt.autoread = true
opt.hlsearch = true
opt.lazyredraw = true
opt.showmatch = true
opt.hidden = true
opt.termguicolors = true

-- Return to last edit position when opening files
cmd [[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]

-- Initialize COQ
cmd [[au VimEnter * COQnow --shut-up]]

-- Sorry, no beige.
cmd [[colorscheme default]]

cmd [[
  autocmd ColorScheme * hi Pmenu guifg=#f8f8f0 guibg=#333842
  autocmd ColorScheme * hi FloatBorder guifg=#f8f8f0 guibg=#333842
  autocmd ColorScheme * hi PmenuSel guifg=#333842 guibg=#fd971f
  autocmd ColorScheme * hi PmenuSelBold guifg=#333842 guibg=#fd971f
  autocmd ColorScheme * hi PmenuThumb guifg=#ae81ff guibg=#a6e22e
  autocmd ColorScheme * hi PmenuSbar guifg=NONE guifg=#3f444a
]]

cmd [[
  command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview(), <bang>0)
]]

g.NERDTreeQuitOnOpen = 1
g['$FZF_DEFAULT_OPTS'] = "--ansi --preview 'bat --color=always --style=grid {}' --preview-window 'right:40%' --margin=1,4"
g.fzf_layout = {
  window = {
    width = 0.8,
    height = 0.9,
  }
}
