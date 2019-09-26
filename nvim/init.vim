""""""" init.vim """""""
" good tutorial: https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/
"

"""""" plugvim settings
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-clangx' "clang completion
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/neopairs.vim'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neoinclude.vim'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'benekastah/neomake'
Plug 'davidhalter/jedi-vim'
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'sbdchd/neoformat'
Plug 'mhinz/vim-signify' "show changes on left col
Plug 'Raimondi/delimitMate' "autoclose brackets etc
Plug 'vim-syntastic/syntastic' "syntax checking
Plug 'benmills/vimux'
Plug 'scrooloose/nerdtree'
Plug 'lervag/vimtex'
Plug 'rust-lang/rust.vim'
Plug 'fholgado/minibufexpl.vim'
"Plug 'racer-rust/vim-racer'
"Plug 'kien/ctrlp.vim'

" After all plugins...
call plug#end()

""""""" General coding stuff 
set laststatus=2 " Always show status bar
set updatetime=100 " Let plugins show effects after 100ms, not 4s
set mouse-=a " Disable mouse click to go to position
set completeopt=menuone,preview,noinsert " Don't let autocomplete affect usual typing habits
set enc =utf-8 " encoding
set nocompatible
filetype off
syntax on
set background=dark
colorscheme desert
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set dir=/tmp/
set relativenumber 
set number
" set nofoldenable
set cursorline
hi Cursor ctermfg=White ctermbg=Yellow cterm=bold guifg=white guibg=yellow gui=bold
set hlsearch
set backspace=indent,eol,start
"Detect file type
filetype plugin indent on

"""""" gitgutter settings
" Let vim-gitgutter do its thing on large files
let g:gitgutter_max_signs=10000

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

"""""" Deoplete settings
let g:deoplete#enable_at_startup = 1
let g:neopairs#enable = 1
" Python host prog 
let hostname = substitute(system('hostname'), '\n', '', '')
if hostname == "ThinkPad.local.tobias-weiss.org" 
  let g:python3_host_prog = '/usr/local/bin/python3.7'
endif
"
" Change clang binary path
call deoplete#custom#var('clangx', 'clang_binary', '/usr/bin/clang')

" Change clang options
call deoplete#custom#var('clangx', 'default_c_options', '')
call deoplete#custom#var('clangx', 'default_cpp_options', '')

" Use smartcase.
let g:deoplete#enable_smart_case = 1
"
" Set minimum syntax keyword length.
let g:deoplete#sources#syntax#min_keyword_length = 3

" delay a little bit
call deoplete#custom#option('auto_complete_delay', 200)

" completion bracket
call deoplete#custom#source('_', 'converters', ['converter_auto_paren'])

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

" Close popup by <Space>.
" disables because of weired behavior with normal spaces
" inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" Option menu to choose completion candidate
" deoplete tab-complete
"inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>""

call deoplete#custom#option('candidate_marks',
    \ ['tab', 'A', 'S', 'D', 'F', 'G'])
inoremap <expr><tab>       pumvisible() ?
\ deoplete#insert_candidate(0) : 'tab'
inoremap <expr>A       pumvisible() ?
\ deoplete#insert_candidate(0) : 'A'
inoremap <expr>S       pumvisible() ?
\ deoplete#insert_candidate(1) : 'S'
inoremap <expr>D       pumvisible() ?
\ deoplete#insert_candidate(2) : 'D'
inoremap <expr>F       pumvisible() ?
\ deoplete#insert_candidate(3) : 'F'
inoremap <expr>G       pumvisible() ?
\ deoplete#insert_candidate(4) : 'G'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" work with tex
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})

"""""" denite settings
" Define mappings
"autocmd FileType denite call s:denite_my_settings()
"function! s:denite_my_settings() abort
"  nnoremap <silent><buffer><expr> <CR>
"  \ denite#do_map('do_action')
"  nnoremap <silent><buffer><expr> d
"  \ denite#do_map('do_action', 'delete')
"  nnoremap <silent><buffer><expr> p
"  \ denite#do_map('do_action', 'preview')
"  nnoremap <silent><buffer><expr> q
"  \ denite#do_map('quit')
"  nnoremap <silent><buffer><expr> i
"  \ denite#do_map('open_filter_buffer')
"  nnoremap <silent><buffer><expr> <Space>
"  \ denite#do_map('toggle_select').'j'
"endfunction

"""""" neosnippet settings
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)


"""""" Jedivim settings
" disable jedi autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled = 0
" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"
" Don't mess up undo history
"let g:jedi#show_call_signatures = "0"
"let g:jedi#use_tabs_not_buffers = 1
"let g:jedi#use_splits_not_buffers = "left"
"let g:jedi#popup_on_dot = 1


""""""" source other dotfiles
" Python specifics
autocmd BufRead,BufNewFile,FileReadPost *.py source ~/dotfiles/nvim/python-vimrc.vim
" C++ specifics
autocmd BufRead,BufNewFile,FileReadPost *.cpp source ~/dotfiles/nvim/cpp-vimrc.vim
" Latex specifics
autocmd BufRead,BufNewFile,FileReadPost *.tex source ~/dotfiles/nvim/tex-vimrc.vim
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'

""""""" signify settings 
let g:signify_vcs_list = [ 'git' ]

""""""" neomake settings
" Neomake and other build commands (ctrl-b)
nnoremap <C-b> :w<cr>:Neomake<cr>
call neomake#configure#automake('w')
" let g:neomake_python_enabled_makers = ['pep8', 'flake8']

"""""" neoformat settings
" Enable alignment
let g:neoformat_basic_format_align = 1
" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1
" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

""""""" Keybindings
" Set up leaders
let mapleader=","
let maplocalleader="\\"

nnoremap <C-l> :nohl<CR><C-l>:echo "Search Cleared"<CR>
nnoremap <C-c> :set norelativenumber<CR>:set nonumber<CR>:echo "Line numbers turned off."<CR>
nnoremap <C-n> :set relativenumber<CR>:set number<CR>:echo "Line numbers turned on."<CR>

nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap H 0
nnoremap L $
nnoremap J G
nnoremap K gg

nnoremap <Space> za
nnoremap <leader>z zMzvzz

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

nnoremap <leader>e :Ex<CR>
nnoremap <leader>t :tabnew<CR>:Ex<CR>
nnoremap <leader>v :vsplit<CR>:w<CR>:Ex<CR>
"nnoremap <leader>s :split<CR>:w<CR>:Ex<CR>
nnoremap <leader>r :so /home/weiss/dotfiles/nvim/init.vim<cr>

nnoremap <leader>n :NERDTreeToggle<CR>

" MiniBufExpl
let g:miniBufExplorerAutoStart = 0
map <Leader>e :MBEOpen<cr>
map <Leader>c :MBEClose<cr>
map <Leader>t :MBEToggle<cr>

" Help navigation
"   nnoremap <buffer> <CR> <C-]>
"   nnoremap <buffer> <BS> <C-T>
"   nnoremap <buffer> o /'\l\{2,\}'<CR>
"   nnoremap <buffer> O ?'\l\{2,\}'<CR>
"   nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>
"   nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>

" ---------------------------------- "
" config for my laptop only
" ---------------------------------- "
let hostname = substitute(system('hostname'), '\n', '', '')
if hostname == "ThinkPad.local.tobias-weiss.org" 
    " load templates
    autocmd BufNewFile *.py 0r ~/git/repo/01_coden/python/dummy.py|3
    autocmd BufNewFile *.c 0r ~/git/repo/01_coden/c/dummy.c
    autocmd BufNewFile *.h 0r ~/git/repo/01_coden/c/dummy.h
    autocmd BufNewFile,BufWritePre,FileWritePre *.[ch] ks|exe "1," . 5 . "g/file:.*/s//file: " .expand("%")|'s

    """" Replace modify date on writing file
    autocmd BufWritePre,FileWritePre *.[ch]   ks|call LastMod()|'s
    fun! LastMod()
      if line("$") > 20
        let l = 20
      else
        let l = line("$")
      endif
      exe "1," . l . "g/Last modified: /s/Last modified: .*/Last modified: " strftime("%Y %b %d %X")
    endfun
endif

""""""" Rust stuff
"let g:rustfmt_autosave = 1
"set hidden
"let g:racer_cmd = "/home/user/.cargo/bin/racer"

