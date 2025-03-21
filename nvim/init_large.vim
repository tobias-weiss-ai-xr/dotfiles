""""""" init.vim """""""
" good tutorial: https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/

set path+=** " add actual folder to path

" get hostname
let hostname = substitute(system('hostname'), '\n', '', '')

" load templates
autocmd BufNewFile *.py 0r ~/git/code/python/dummy.py|3
autocmd BufNewFile *.c 0r ~/git/code/c/dummy.c
autocmd BufNewFile *.h 0r ~/git/code/c/dummy.h
autocmd BufNewFile,BufWritePre,FileWritePre *.[ch] ks|exe "1," . 5 . "g/file:.*/s//file: " .expand("%")|'s
autocmd BufNewFile *.cpp 0r ~/git/code/cpp/dummy.cpp|7

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

" plugvim settings
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'deoplete-plugins/deoplete-clang' "clang completion
"Plug 'deoplete-plugins/deoplete-jedi'
"Plug 'Shougo/denite.nvim'
Plug 'lambdalisue/suda.vim'
Plug 'Shougo/neopairs.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/neoinclude.vim'
"Plug 'SirVer/ultisnips'
Plug 'benekastah/neomake'
Plug 'davidhalter/jedi-vim'
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'sbdchd/neoformat'
Plug 'mhinz/vim-signify' "show changes on left col
Plug 'Raimondi/delimitMate' "autoclose brackets etc
Plug 'vim-syntastic/syntastic' "syntax checking
" Plug 'benmills/vimux'
" Use vimux forked version until RunnerPane is merged
Plug 'tobiasweede/vimux', { 'branch': 'set_pane' }
Plug 'scrooloose/nerdtree'
Plug 'lervag/vimtex'
" Using a non-master branch
" Plug 'tobiasweede/vimtex', { 'branch': 'add-pdf-viewer-positioning' }
Plug 'rust-lang/rust.vim'
Plug 'fholgado/minibufexpl.vim'
"Plug 'racer-rust/vim-racer'
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'
Plug 'jalvesaq/Nvim-R'
"Plug 'SkyLeach/pudb.vim'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-match-highlight'
Plug 'ncm2/ncm2-pyclang'
Plug 'ncm2/ncm2-racer'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-neosnippet'
Plug 'gaalcaras/ncm-R'
" After all plugins...
call plug#end()

" General coding stuff
set laststatus=2 " Always show status bar
set updatetime=100 " Let plugins show effects after 100ms, not 4s
set mouse-=a " Disable mouse click to go to position
set completeopt=menuone,preview,noinsert " Don't let autocomplete affect usual typing habits
set enc =utf-8 " encoding
set nocompatible
syntax on
set background=dark
"colorscheme desert
colorscheme darkblue
set autoindent
set tabstop=4
set shiftwidth=4
set colorcolumn=80
set expandtab
set dir=/tmp/
set relativenumber
set number
" set nofoldenable
" set cursorline
hi Cursor ctermfg=lightgray ctermbg=Yellow cterm=bold 
hi MatchParen cterm=bold ctermfg=blue ctermbg=Yellow 
set hlsearch
set backspace=indent,eol,start
"Detect file type
filetype plugin indent on

" enable ncm2 for all buffers

" vim misinterpretes <C-Space> as <C-@> ...
" https://stackoverflow.com/questions/7722177/how-do-i-map-ctrl-x-ctrl-o-to-ctrl-space-in-terminal-vim/7725796#7725796
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

au BufEnter * call ncm2#enable_for_buffer()
au User Ncm2Plugin call ncm2#register_source({
            \ 'name' : 'vimtex',
            \ 'priority': 1,
            \ 'subscope_enable': 1,
            \ 'complete_length': 1,
            \ 'scope': ['tex'],
            \ 'matcher': {'name': 'combine',
            \           'matchers': [
            \               {'name': 'abbrfuzzy', 'key': 'menu'},
            \               {'name': 'prefix', 'key': 'word'},
            \           ]},
            \ 'mark': 'tex',
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm,
            \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            \ })

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
            \ 'name' : 'css',
            \ 'priority': 9,
            \ 'subscope_enable': 1,
            \ 'scope': ['css','scss'],
            \ 'mark': 'css',
            \ 'word_pattern': '[\w\-]+',
            \ 'complete_pattern': ':\s*',
            \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
            \ })

" path to directory where libclang.so can be found
let g:ncm2_pyclang#library_path =  '/usr/lib/llvm-6.0/lib'

" gitgutter settings
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

" Close paranthesis automatically
let g:neopairs#enable = 1

" r start libs
let R_start_libs = 'base,stats,graphics,grDevices,utils,methods'


"""""" neosnippet settings
" Custom snip path
let g:neosnippet#snippets_directory="~/dotfiles/nvim/own-neosnippets/"

" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

"""""" Jedivim settings
let g:jedi#completions_enabled = 1
" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"
" Don't mess up undo history
let g:jedi#show_call_signatures = "0"

""""""" source other dotfiles
" Python specifics
autocmd BufRead,BufNewFile,FileReadPost *.py source ~/dotfiles/nvim/python-vimrc.vim

" C++ specifics
autocmd BufRead,BufNewFile,FileReadPost *.cpp source ~/dotfiles/nvim/cpp-vimrc.vim

" Latex specifics
autocmd BufRead,BufNewFile,FileReadPost *.tex source ~/dotfiles/nvim/tex-vimrc.vim

""""""" further tex specific config not placeable in tex-vimrc.vim file
" Don't know why the following settings only work here
" Maybe FileReadPre could help for the autocmd
" Test it if there is some spare time...
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
"let g:vimtex_view_method = 'mupdf'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_latexmk_build_dir = './build'
" hide quickfix taba after two keystrokes
let g:vimtex_quickfix_mode = '2'
let g:vimtex_quickfix_autoclose_after_keystrokes = '2'

" do not move into tex-vimrc as it breaks it!
let g:vimtex_toc_config = {
			\ 'name' : 'TOC',
			\ 'layers' : ['content', 'todo', 'include'],
			\ 'resize' : 0, 
			\ 'split_width' : 20,
			\ 'todo_sorted' : 0,
			\ 'show_help' : 1,
			\ 'show_numbers' : 1,
			\ 'mode' : 2,
			\} 
 
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_types = {
      \ 'preamble' : {'enabled' : 0},
      \ 'envs' : {
      \   'blacklist' : ['figure', 'table'],
      \ },
      \}

" deprecated...
"" PDF viewer positioning
"let g:vimtex_view_zathura_hook_view = 'ViewerPosition'
"let g:vimtex_view_zathura_hook_callback = 'ViewerPosition'
"
"function! ViewerPosition() abort dict
"    call self.move('0 0')
"    if g:hostname == "ThinkPad.local.tobias-weiss.org"
"        call self.resize('1366 742')
"    else
"        call self.resize('1600 870')
"    endif
"endfunction

""""""" neomake settings
" Neomake and other build commands (ctrl-b)
nnoremap <C-b> :w<cr>:Neomake<cr>
"call neomake#configure#automake('w')
let g:neomake_python_enabled_makers = ['pep8', 'flake8']

"""""" neoformat settings
" Enable alignment
let g:neoformat_basic_format_align = 1
" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1
" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1
" Map Neoformat with leader key
map <silent><leader>f :Neoformat<cr>:retab<cr>

""""""" FastFold
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
let g:markdown_folding = 1
let g:tex_fold_enabled = 1
let g:vimsyn_folding = 'af'
let g:xml_syntax_folding = 1
let g:javaScript_fold = 1
let g:sh_fold_enabled= 7
let g:ruby_fold = 1
let g:perl_fold = 1
let g:perl_fold_blocks = 1
let g:r_syntax_folding = 1
let g:rust_fold = 1
let g:php_folding = 1

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

"nnoremap <leader>e :Ex<CR> " Overwritten by MBEOpen
"nnoremap <leader>t :tabnew<CR>:Ex<CR>
nnoremap <leader>v :vsplit<CR>:w<CR>:Ex<CR>
"nnoremap <leader>s :split<CR>:w<CR>:Ex<CR>
nnoremap <leader>R :so $MYVIMRC<cr>

nnoremap <leader>n :NERDTreeToggle<CR>

" MiniBufExpl
let g:miniBufExplorerAutoStart = 1
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

" Rust stuff
"let g:rustfmt_autosave = 1
"set hidden
"let g:racer_cmd = "/home/user/.cargo/bin/racer"
"

" suda automatically switch a buffer name when the target file is not readable or writable.
let g:suda_smart_edit = 1
