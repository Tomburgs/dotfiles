local env = vim.env
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
opt.number = true
opt.wrap = false
opt.smartcase = true
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
opt.undofile = true
opt.incsearch = true
opt.relativenumber = true
opt.autoread = true
opt.hlsearch = true
opt.lazyredraw = true
opt.showmatch = true
opt.hidden = true
opt.updatetime = 300
-- opt.formatoptions = opt.formatoptions:gsub('[cro]', '')
opt.cursorline = true

opt.termguicolors = true

-- Sorry, no beige.
vim.cmd [[colorscheme gruvbox]]

-- Return to last edit position when opening files
vim.cmd [[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]

vim.cmd [[
  command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview(), <bang>0)
]]

g.NERDTreeQuitOnOpen = 1
g.fzf_preview_command = 'bat --color=always'
g.fzf_preview_quit_map = 1
g.fzf_preview_git_status_preview_command =
    '[[ $(git diff --cached -- {-1}) != \"\" ]] && git diff --cached --color=always -- {-1} | delta || ' ..
    '[[ $(git diff -- {-1}) != \"\" ]] && git diff --color=always -- {-1} | delta || ' ..
    vim.g.fzf_preview_command

g.fzf_layout = {
  window = {
    width = 0.9,
    height = 0.9,
  }
}

env.FZF_DEFAULT_OPTS =
"--ansi --layout reverse --margin=1,4"
-- Preview flag: --preview 'bat --color=always --style=grid {}' --preview-window 'right:50%'
