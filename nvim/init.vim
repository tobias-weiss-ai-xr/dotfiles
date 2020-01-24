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
"Plug 'Shougo/deoplete-clangx' "clang completion
Plug 'deoplete-plugins/deoplete-clang' "clang completion
"Plug 'tweekmonster/deoplete-clang2' "clang completion
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'Shougo/neopairs.vim'
Plug 'Shougo/denite.nvim'
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
Plug 'benmills/vimux'
Plug 'scrooloose/nerdtree'
Plug 'lervag/vimtex'
Plug 'rust-lang/rust.vim'
Plug 'fholgado/minibufexpl.vim'
"Plug 'racer-rust/vim-racer'
"Plug 'kien/ctrlp.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'jalvesaq/Nvim-R'

" After all plugins...
call plug#end()

""""""" General coding stuff
set laststatus=2 " Always show status bar
set updatetime=100 " Let plugins show effects after 100ms, not 4s
set mouse-=a " Disable mouse click to go to position
set completeopt=menuone,preview,noinsert " Don't let autocomplete affect usual typing habits
set enc =utf-8 " encoding
set nocompatible
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

" Close paranthesis automatically
let g:neopairs#enable = 1

"""""" Deoplete settings
let g:deoplete#enable_at_startup = 1
" Python host prog
let hostname = substitute(system('hostname'), '\n', '', '')
if hostname == "ThinkPad.local.tobias-weiss.org"
    let g:python3_host_prog = '/usr/local/bin/python3.7'
endif
"
" Change clang binary path
" clangx approach
" call deoplete#custom#var('clangx', 'clang_binary', '/usr/bin/clang')
" call deoplete#custom#var('clangx', 'default_c_options', '')
" call deoplete#custom#var('clangx', 'default_cpp_options', '')
" clang2 approach
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-6.0/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-6.0/lib/clang'

" Use smartcase
let g:deoplete#enable_smart_case = 1
"
" Set minimum syntax keyword length
let g:deoplete#sources#syntax#min_keyword_length = 0

" delay a little bit
call deoplete#custom#option('auto_complete_delay', 100)

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
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

call deoplete#custom#option('candidate_marks',
            \ ['A', 'S', 'D', 'F', 'G'])
"    \ ['tab', 'A', 'S', 'D', 'F', 'G'])
"inoremap <expr><tab>       pumvisible() ?
            "\ deoplete#insert_candidate(0) : 'tab'
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

"call deoplete#custom#option('sources', {
"            \ '_': ['file', 'buffer'],
"            \ 'python': ['LanguageClient', 'ultisnips'],
"            \ 'python3': ['LanguageClient', 'ultisnips'],
"            \ 'rust': ['LanguageClient', 'ultisnips'],
"            \ 'tex': ['omni'],
"            \ 'r': ['omni']
"            \})

" r start libs
let R_start_libs = 'base,stats,graphics,grDevices,utils,methods'

" work with tex and r
call deoplete#custom#var('omni', 'input_patterns', {
            \ 'tex': g:vimtex#re#deoplete,
            \ 'r': '[*\t]\.\w*',
            \})

"""""" denite settings
" Define mappings
"
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
                \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d
                \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
                \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
                \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
                \ denite#do_map('toggle_select').'j'
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
    imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
endfunction

" Change file/rec command.
call denite#custom#var('file/rec', 'command',
            \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
" For ripgrep
" Note: It is slower than ag
call denite#custom#var('file/rec', 'command',
            \ ['rg', '--files', '--glob', '!.git'])
" For Pt(the platinum searcher)
" NOTE: It also supports windows.
call denite#custom#var('file/rec', 'command',
            \ ['pt', '--follow', '--nocolor', '--nogroup',
            \  (has('win32') ? '-g:' : '-g='), ''])
" For python script scantree.py
" Read bellow on this file to learn more about scantree.py
call denite#custom#var('file/rec', 'command',
            \ ['scantree.py', '--path', ':directory'])

" Change matchers.
call denite#custom#source(
            \ 'file_mru', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])
call denite#custom#source(
            \ 'file/rec', 'matchers', ['matcher/cpsm'])

" Change sorters.
call denite#custom#source(
            \ 'file/rec', 'sorters', ['sorter/sublime'])

" Change default action.
call denite#custom#kind('file', 'default_action', 'split')

" Add custom menus
let s:menus = {}

let s:menus.zsh = {
            \ 'description': 'Edit your import zsh configuration'
            \ }
let s:menus.zsh.file_candidates = [
            \ ['zshrc', '~/.config/zsh/.zshrc'],
            \ ['zshenv', '~/.zshenv'],
            \ ]

let s:menus.my_commands = {
            \ 'description': 'Example commands'
            \ }
let s:menus.my_commands.command_candidates = [
            \ ['Split the window', 'vnew'],
            \ ['Open zsh menu', 'Denite menu:zsh'],
            \ ['Format code', 'FormatCode', 'go,python'],
            \ ]

call denite#custom#var('menu', 'menus', s:menus)

" Ag command on grep source
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
            \ ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Ack command on grep source
call denite#custom#var('grep', 'command', ['ack'])
call denite#custom#var('grep', 'default_opts',
            \ ['--ackrc', $HOME.'/.ackrc', '-H', '-i',
            \  '--nopager', '--nocolor', '--nogroup', '--column'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--match'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Ripgrep command on grep source
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
            \ ['-i', '--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Pt command on grep source
call denite#custom#var('grep', 'command', ['pt'])
call denite#custom#var('grep', 'default_opts',
            \ ['-i', '--nogroup', '--nocolor', '--smart-case'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" jvgrep command on grep source
call denite#custom#var('grep', 'command', ['jvgrep'])
call denite#custom#var('grep', 'default_opts', ['-i'])
call denite#custom#var('grep', 'recursive_opts', ['-R'])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', [])
call denite#custom#var('grep', 'final_opts', [])

" Specify multiple paths in grep source
"call denite#start([{'name': 'grep',
"      \ 'args': [['a.vim', 'b.vim'], '', 'pattern']}])

" Define alias
call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command',
            \ ['git', 'ls-files', '-co', '--exclude-standard'])

call denite#custom#alias('source', 'file/rec/py', 'file/rec')
call denite#custom#var('file/rec/py', 'command',
            \ ['scantree.py', '--path', ':directory'])

" Change ignore_globs
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
            \ [ '.git/', '.ropeproject/', '__pycache__/',
            \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

" Custom action
" Note: lambda function is not supported in Vim8.
call denite#custom#action('file', 'test',
            \ {context -> execute('let g:foo = 1')})
call denite#custom#action('file', 'test2',
            \ {context -> denite#do_action(
            \  context, 'open', context['targets'])})

"""""" neosnippet settings
" Custom snip path
let g:neosnippet#snippets_directory="~/dotfiles/nvim/own-neosnippets/"

" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets' behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
            \ pumvisible() ? "\<C-n>" :
            \ neosnippet#expandable_or_jumpable() ?
            \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

"""""" Jedivim settings
" disable jedi autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled = 0
" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"
" Don't mess up undo history
let g:jedi#show_call_signatures = "0"
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
let g:neomake_python_enabled_makers = ['pep8', 'flake8']

"""""" neoformat settings
" Enable alignment
let g:neoformat_basic_format_align = 1
" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1
" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1
" Map Neoformat with leader key
nnoremap <leader>f :Neoformat<cr>

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
"nnoremap <leader>t :tabnew<CR>:Ex<CR>
nnoremap <leader>v :vsplit<CR>:w<CR>:Ex<CR>
"nnoremap <leader>s :split<CR>:w<CR>:Ex<CR>
nnoremap <leader>r :so $MYVIMRC<cr>

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
    autocmd BufNewFile *.cpp 0r ~/git/repo/01_coden/cpp/dummy.cpp|7

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
