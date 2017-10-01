" General Vim settings
	colorscheme elflord
	let mapleader=","
	syntax on
	set autoindent
	set tabstop=4
	set shiftwidth=4
	set dir=/tmp/
	set relativenumber 
	set number

	" encoding
	set enc =utf-8

	set cursorline
	hi Cursor ctermfg=White ctermbg=Yellow cterm=bold guifg=white guibg=yellow gui=bold

	set hlsearch
	nnoremap <C-l> :nohl<CR><C-l>:echo "Search Cleared"<CR>
	nnoremap <C-c> :set norelativenumber<CR>:set nonumber<CR>:echo "Line numbers turned off."<CR>
	nnoremap <C-n> :set relativenumber<CR>:set number<CR>:echo "Line numbers turned on."<CR>

	nnoremap n nzzzv
	nnoremap N Nzzzv

	nnoremap H 0
	nnoremap L $
	nnoremap J G
	nnoremap K gg

	"map <tab> %

	set backspace=indent,eol,start

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

" Return to the same line you left off at
	augroup line_return
		au!
		au BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\	execute 'normal! g`"zvzz' |
			\ endif
	augroup END


"" Templates / Language specifics
autocmd BufRead,BufNewFile,FileReadPost *.py source ~/dotfiles/vim/vimrc.python

"" Enable Pathogen plugin bundle manager
execute pathogen#infect()
filetype plugin indent on 

""" load templates
autocmd BufNewFile *.py 0r ~/git/repo/01_coden/python/dummy.py|3
autocmd BufNewFile *.c 0r ~/git/repo/01_coden/c/dummy.c
autocmd BufNewFile *.h 0r ~/git/repo/01_coden/c/dummy.h
autocmd BufNewFile,BufWritePre,FileWritePre *.[ch] ks|exe "1," . 5 . "g/file:.*/s//file: " .expand("%")|'s
"
"""remove trailing whitespaces
autocmd BufWritePre *.py :%s/\s\+$//e

"""" Replace modify date on writing file
autocmd BufWritePre,FileWritePre *.[ch]   ks|call LastMod()|'s
fun LastMod()
  if line("$") > 20
    let l = 20
  else
    let l = line("$")
  endif
  exe "1," . l . "g/Last modified: /s/Last modified: .*/Last modified: " strftime("%Y %b %d %X")
endfun

" Tell vim to remember certain things when we exit
" "  '10  :  marks will be remembered for up to 10 previously edited files
" "  "100 :  will save up to 100 lines for each register
" "  :20  :  up to 20 lines of command-line history will be remembered
" "  %    :  saves and restores the buffer list
" "  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

"" NerdTree 
let NERDTreeIgnore=['\.pyc']
"autostart if no file given
autocmd VimEnter * if !argc() | NERDTree | endif

"" Tex Hax
let g:tex_flavor='latex'

""close quotes automatically (delimitMate)
let delimitMate_expand_cr = 1

" ---------------------------------- "
" Configure MiniBufExpl
" ---------------------------------- "

" Open MiniBufExpl with Ctrl-m
map <C-m> :MBEToggle<CR>

" ---------------------------------- "
" Configure Tagbar
" ---------------------------------- "

" Open Tagbar with F8
map <F8> :TagbarToggle<CR>

" ---------------------------------- "
" Configure Ultisnip and YouCompleteMe
" ---------------------------------- "

let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" ---------------------------------- "
" Configure YouCompleteMe
" ---------------------------------- "

let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']

" Goto definition with F3
map <F3> :YcmCompleter GoTo<CR>
