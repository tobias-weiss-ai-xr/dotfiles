""""""" init.vim """""""
" encoding
set enc =utf-8
set nocompatible
filetype off
syntax on
set background=dark
colorscheme desert
set autoindent
set tabstop=4
set shiftwidth=4
set dir=/tmp/
set relativenumber 
set number
set nofoldenable
set cursorline
hi Cursor ctermfg=White ctermbg=Yellow cterm=bold guifg=white guibg=yellow gui=bold
set hlsearch
set backspace=indent,eol,start

" Return to the same line you left off at
	augroup line_return
		au!
		au BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\	execute 'normal! g`"zvzz' |
			\ endif
	augroup END

" Tell vim to remember certain things when we exit
" "  '10  :  marks will be remembered for up to 10 previously edited files
" "  "100 :  will save up to 100 lines for each register
" "  :20  :  up to 20 lines of command-line history will be remembered
" "  %    :  saves and restores the buffer list
" "  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.config/nvim/.viminfo

""""""" Vundel """""""
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')

Plugin 'VundleVim/Vundle.vim'

" Track the engine.
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" Ctrl-P - Fuzzy file search
"Plugin 'kien/ctrlp.vim'
" Neomake build tool (mapped below to <c-b>)
Plugin 'benekastah/neomake'
"
" Autocomplete
Plugin 'davidhalter/jedi-vim'

" Status bar mods
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'

" Tab completion
Plugin 'ervandew/supertab'

" YouCompleteMe
Plugin 'Valloric/YouCompleteMe'

" Python mode
Plugin 'python-mode/python-mode'

" Plugin 'vimlatex'
Plugin 'lervag/vimtex'

" Plugin signify
Plugin 'mhinz/vim-signify'

" Plugin DeliMate
Plugin 'Raimondi/delimitMate'

" Plugin Syntastic
Plugin 'vim-syntastic/syntastic'

" Plugin Rust.vim
Plugin 'rust-lang/rust.vim'

" Plugin Rust race (completion)
Plugin 'racer-rust/vim-racer'

" After all plugins...
call vundle#end()
filetype plugin indent on

""""""" source other dotfiles """""""
" Python specifics
autocmd BufRead,BufNewFile,FileReadPost *.py source ~/dotfiles/nvim/python-vimrc.vim
" Latex specifics
autocmd BufRead,BufNewFile,FileReadPost *.tex source ~/dotfiles/nvim/tex-vimrc.vim
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'

""""""" signify settings """""""
let g:signify_vcs_list = [ 'git' ]

""""""" Neomake """""""
" Neomake and other build commands (ctrl-b)
nnoremap <C-b> :w<cr>:Neomake<cr>
call neomake#configure#automake('w')
let g:neomake_python_enabled_makers = ['pep8', 'flake8']

""""" Jedi-VIM """""""
" Don't mess up undo history
let g:jedi#show_call_signatures = "0"
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#popup_on_dot = 1

""""""" SuperTab configuration """""""
let g:SuperTabDefaultCompletionType = "<c-x><c-u>"
function! Completefunc(findstart, base)
    return "\<c-x>\<c-p>"
endfunction
    "call SuperTabChain(Completefunc, '<c-n>')
    "let g:SuperTabCompletionContexts = ['g:ContextText2']

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<M-e>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

""""""" General coding stuff """""""
" Highlight 80th column
set colorcolumn=80
" Always show status bar
set laststatus=2
" Let plugins show effects after 100ms, not 4s
set updatetime=100
" Disable mouse click to go to position
set mouse-=a
" Don't let autocomplete affect usual typing habits
set completeopt=menuone,preview,noinsert
" Let vim-gitgutter do its thing on large files
let g:gitgutter_max_signs=10000

""""""" Keybindings """""""
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

inoremap <leader>q <ESC>:q<CR>
nnoremap <leader>q :q<CR>

inoremap <leader>x <ESC>:x<CR>
nnoremap <leader>x :x<CR>

nnoremap <leader>e :Ex<CR>
nnoremap <leader>t :tabnew<CR>:Ex<CR>
nnoremap <leader>v :vsplit<CR>:w<CR>:Ex<CR>
nnoremap <leader>s :split<CR>:w<CR>:Ex<CR>

" Help navigation
"	nnoremap <buffer> <CR> <C-]>
"	nnoremap <buffer> <BS> <C-T>
"	nnoremap <buffer> o /'\l\{2,\}'<CR>
"	nnoremap <buffer> O ?'\l\{2,\}'<CR>
"	nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>
"	nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>

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

" ---------------------------------- "
" Rust stuff
" ---------------------------------- "
let g:rustfmt_autosave = 1
set hidden
let g:racer_cmd = "/home/user/.cargo/bin/racer"

" ---------------------------------- "
" C++ stuff
" ---------------------------------- "
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/.ycm_extra_conf.py'
