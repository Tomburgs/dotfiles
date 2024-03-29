syntax on

set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set relativenumber
set autoread
set hlsearch
set lazyredraw
set showmatch
set hidden
set clipboard=unnamed " use system clipboard
set updatetime=300
set mouse=
set formatoptions-=cro
set cursorline

set termguicolors

colorscheme default

hi CocErrorFloat guifg=#e95678 guibg=NONE
hi CocWarningFloat guifg=#e6db74 guibg=NONE
hi CocInfoFloat guifg=#64645e guibg=NONE

hi Pmenu guifg=#f8f8f0 guibg=#333842
hi PmenuSel guifg=#333842 guibg=#fd971f
hi PmenuSelBold guifg=#333842 guibg=#fd971f
hi PmenuThumb guifg=#ae81ff guibg=#a6e22e
hi PmenuSbar guifg=NONE guifg=#3f444a

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release/rpc', 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'mkitt/tabline.vim'
Plug 'LucHermitte/lh-vim-lib', { 'name': 'lh-vim-lib' }
Plug 'LucHermitte/local_vimrc', { 'depends': 'lh-vim-lib' }
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'puremourning/vimspector'

Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()

" Make it all colorful
set background=dark
colorscheme gruvbox

let mapleader = " "
let NERDTreeQuitOnOpen = 1
let g:local_vimrc = ['.local.vim']
let g:coc_global_extensions = [
   \ 'coc-clangd',
   \ 'coc-pairs',
   \ 'coc-tsserver',
   \ 'coc-go',
   \ 'coc-pyright',
   \ 'coc-deno',
   \ 'coc-prettier',
   \ 'coc-eslint8',
   \ 'coc-stylelintplus',
   \ 'coc-json',
   \ 'coc-css',
   \ 'coc-cssmodules',
   \ 'coc-html',
   \ 'coc-metals',
   \ 'coc-flutter',
   \ 'coc-prisma'
   \ ]

let g:fzf_preview_command = 'bat --color=always'
let g:fzf_preview_quit_map = 1
let g:fzf_preview_git_status_preview_command =
   \ "[[ $(git diff --cached -- {-1}) != \"\" ]] && git diff --cached --color=always -- {-1} | delta || " .
   \ "[[ $(git diff -- {-1}) != \"\" ]] && git diff --color=always -- {-1} | delta || " .
   \ g:fzf_preview_command

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let $FZF_DEFAULT_OPTS="--ansi --preview 'bat --color=always --style=grid {}' --preview-window 'right:50%' --layout reverse --margin=1,4"

let g:vimspector_enable_mappings = 'HUMAN'

command! -bang -nargs=* Ag
   \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview(), <bang>0)

" Moving around windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Managing tabs
nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>tc :tabclose<CR>
nnoremap <Leader>to :tabonly<CR>
nnoremap <Leader>tm :tabmove 
nnoremap <Leader>te :tabedit <C-r>=expand("%:p:h")<CR>/

nnoremap <F1> <Plug>VimspectorBalloonEval<CR>
nnoremap <F2> :VimspectorReset<CR>

" Managing COC
nnoremap <silent> <Leader>gd :call CocActionAsync('jumpDefinition', 'drop')<CR>
nnoremap <silent> <Leader>gr :call CocActionAsync('jumpReferences')<CR>
nnoremap <silent> <Leader>i :call CocActionAsync('doHover')<CR>

nnoremap <silent> <Leader>ca :call CocActionAsync('codeAction', 'cursor')<CR>

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" nnoremap <silent> <Leader>ca :call CocActionAsync('codeAction', visualmode())<CR>

" File system
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <Leader>b :NERDTree %<CR>
nnoremap <Leader>ff :FZF<CR>
nnoremap <Leader>ft :Ag<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>gs :FzfPreviewGitStatusRpc<CR>

" Useful utilities
nnoremap <silent> <Leader><CR> :noh<CR>
nnoremap <Leader>ss :setlocal spell!<CR>

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

function RunFlutterWithDevLog()
   :CocCommand flutter.run --dds-port 42424
   sleep 200m
   :CocCommand flutter.dev.openDevLog
endfunction

" Flutter commands
:command! FlutterRun :call RunFlutterWithDevLog()
:command! FlutterAttach :CocCommand flutter.attach --device-vmservice-port 42424
:command! FlutterDevLog :CocCommand flutter.dev.openDevLog
:command! FlutterOutline :CocCommand flutter.toggleOutline
:command! FlutterHotRestart :CocCommand flutter.dev.hotRestart

lua <<EOF
require('nvim-treesitter.configs').setup({
   highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
   },
   context_commentstring = {
      enable = true
   },
})

require('lualine').setup({
  options = {
    theme = 'gruvbox'
  }
})
EOF
