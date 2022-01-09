""""""" init.vim """""""


" plugvim settings
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'lambdalisue/suda.vim'
Plug 'Shougo/neopairs.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'bling/vim-airline'
" After all plugins...
call plug#end()

" General coding stuff
set laststatus=2 " Always show status bar
set updatetime=100 " Let plugins show effects after 100ms, not 4s
set completeopt=menuone,preview,noinsert " Don't let autocomplete affect usual typing habits
set enc =utf-8 " encoding
set nocompatible
syntax on
set background=dark
colorscheme darkblue
set autoindent
set tabstop=4
set shiftwidth=4
set colorcolumn=80
set expandtab
set dir=/tmp/
"set relativenumber
set number
hi Cursor ctermfg=lightgray ctermbg=Yellow cterm=bold 
hi MatchParen cterm=bold ctermfg=blue ctermbg=Yellow 
set hlsearch
set backspace=indent,eol,start
"Detect file type
filetype plugin indent on

inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>


" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" Return to the same line you left off at
augroup line_return
    au!
    au BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   execute 'normal! g`"zvzz' |
                \ endif
augroup END

" Tell vim to remember certain things when we exit
" "  '10  :  marks will be remembered for up to 10 previously edited files
" "  "100 :  will save up to 100 lines for each register
" "  :20  :  up to 20 lines of command-line history will be remembered
" "  %    :  saves and restores the buffer list
" "  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.config/nvim/.viminfo

""""""" Keybindings
" Set up leaders
let mapleader=","
let maplocalleader="\\"

nnoremap <C-l> :nohl<CR><C-l>:echo "Search Cleared"<CR>
nnoremap <C-c> :set norelativenumber<CR>:set nonumber<CR>:echo "Line numbers turned off."<CR>
nnoremap <C-n> :set relativenumber<CR>:set number<CR>:echo "Line numbers turned on."<CR>

" copy current line
nnoremap <C-d> yyp

nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap H 0
nnoremap L $
nnoremap J G
nnoremap K gg

nnoremap <leader>Z za
nnoremap <leader>z zM

nnoremap vv 0v$

set listchars=tab:▸\ ,eol:¬
nnoremap <leader><tab> :set list!<cr>

set pastetoggle=<F2>

set incsearch

" Mouse behaviour a/i/.../""
set mouse=""

" File and Window Management
inoremap <leader>w <Esc>:w<CR>
nnoremap <leader>w :w<CR>

inoremap <leader>c <Esc>:w<cr>:! clear && g++ -std=c++17 -Wall -g % -o %:r<cr>:call VimuxRunCommand("./" . expand("%:r"))<cr>
nnoremap <leader>c :w<cr>:! clear && g++ -std=c++17 -Wall -g % -o %:r<cr>:call VimuxRunCommand("./" . expand("%:r"))<cr>

inoremap <leader>q <ESC>:q<CR>
nnoremap <leader>q :q<CR>

inoremap <leader>x <ESC>:x<CR>
nnoremap <leader>x :x<CR>

nnoremap <leader>v :vsplit<CR>:w<CR>:Ex<CR>
"nnoremap <leader>s :split<CR>:w<CR>:Ex<CR>
nnoremap <leader>R :so $MYVIMRC<cr>

" suda automatically switch a buffer name when the target file is not readable or writable.
let g:suda_smart_edit = 1
