" General Vim settings
	let mapleader=","

	syntax on
	set background=dark
	colorscheme desert

    filetype plugin indent on 
	set autoindent
	set tabstop=4
	set shiftwidth=4
	set dir=/tmp/
	set relativenumber 
	set number

	" encoding
	set enc =utf-8
	autocmd Filetype html setlocal sw=2 expandtab
	autocmd Filetype javascript setlocal sw=4 expandtab

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

" Language Specific

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

" Return to the same line you left off at
	augroup line_return
		au!
		au BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\	execute 'normal! g`"zvzz' |
			\ endif
	augroup END

" Templates / Language specifics
autocmd BufRead,BufNewFile,FileReadPost *.py source ~/dotfiles/vim/python-vimrc.vim

" Remove trailing whitespaces for python
autocmd BufWritePre *.py :%s/\s\+$//e



" Tell vim to remember certain things when we exit
" "  '10  :  marks will be remembered for up to 10 previously edited files
" "  "100 :  will save up to 100 lines for each register
" "  :20  :  up to 20 lines of command-line history will be remembered
" "  %    :  saves and restores the buffer list
" "  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" ---------------------------------- "
" Configure MiniBufExpl
" ---------------------------------- "

" Open MiniBufExpl with Ctrl-m
" map <C-m> :MBEToggle<CR>

" ---------------------------------- "
" config for my T440p only
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
	fun LastMod()
	  if line("$") > 20
		let l = 20
	  else
		let l = line("$")
	  endif
	  exe "1," . l . "g/Last modified: /s/Last modified: .*/Last modified: " strftime("%Y %b %d %X")
	endfun
endif
