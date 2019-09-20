" General Vim settings
	let mapleader=","

	syntax on
	set background=dark
	colorscheme desert

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

" Language Specific
	" Tabs
	" so ~/dotfiles/vim/tabs.vim

	" Typescript
		autocmd BufNewFile,BufRead *.ts set syntax=javascript
		autocmd BufNewFile,BufRead *.tsx set syntax=javascript

	" Markup
		inoremap <leader>< <esc>I<<esc>A><esc>yypa/<esc>O<tab>


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

" Enable Pathogen plugin bundle manager
" execute pathogen#infect()
filetype plugin indent on 


" Tell vim to remember certain things when we exit
" "  '10  :  marks will be remembered for up to 10 previously edited files
" "  "100 :  will save up to 100 lines for each register
" "  :20  :  up to 20 lines of command-line history will be remembered
" "  %    :  saves and restores the buffer list
" "  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

"" NerdTree 
" let NERDTreeIgnore=['\.pyc']
"autostart if no file given
" autocmd VimEnter * if !argc() | NERDTree | endif

"" Tex Hax
" let g:tex_flavor='latex'

""close quotes automatically (delimitMate)
" let delimitMate_expand_cr = 1

" ---------------------------------- "
" Configure MiniBufExpl
" ---------------------------------- "

" Open MiniBufExpl with Ctrl-m
" map <C-m> :MBEToggle<CR>

" ---------------------------------- "
" Configure Tagbar
" ---------------------------------- "

" Open Tagbar with F8
" map <F8> :TagbarToggle<CR>

" ---------------------------------- "
" Configure Ultisnip and YouCompleteMe
" ---------------------------------- "

" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" ---------------------------------- "
" Configure YouCompleteMe
" ---------------------------------- "
" let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
" let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
" let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
" let g:ycm_complete_in_comments = 1 " Completion in comments
" let g:ycm_complete_in_strings = 1 " Completion in string
" 
" let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']

" Goto definition with F3
" map <F3> :YcmCompleter GoTo<CR>

" Tern settings
" let g:tern_show_argument_hints='on_hold'
" let g:tern_map_keys=1
 
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
	fun LastMod()
	  if line("$") > 20
		let l = 20
	  else
		let l = line("$")
	  endif
	  exe "1," . l . "g/Last modified: /s/Last modified: .*/Last modified: " strftime("%Y %b %d %X")
	endfun
endif

""" Sop folding for vim-latex
" let Tex_FoldedSections=""
" let Tex_FoldedEnvironments=""
" let Tex_FoldedMisc=""
" Auto load
	" Triger `autoread` when files changes on disk
	" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
	" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
	autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
	set autoread 
	" Notification after file change
	" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
	autocmd FileChangedShellPost *
	  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Future stuff
	"Swap line
	"Insert blank below and above

" Fix for: https://github.com/fatih/vim-go/issues/1509

filetype plugin indent on
