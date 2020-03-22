""""""" Python specific VIM settings """""""
" Highlight column 80 for PEP-8
set colorcolumn=80
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

" Remove trailing whitespaces for python
autocmd BufWritePre *.py :%s/\s\+$//e

set ts=4 sw=4 sta et sts=4 ai
"set tw=78 "no more automatic line breaks

" More syntax highlighting.
let python_highlight_all = 1

" Smart indenting
set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" set proper indentation for comments
inoremap # X<c-h>#<space>

highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" mapping to souce all souce files
noremap <leader>R :so $MYVIMRC<cr>:so ~/dotfiles/nvim/python-vimrc.vim<cr>

" Map execution of actual file
" map <F5> :! clear & python % &
" map <F6> :! clear & python3 % &
"map <silent><F5> :w<cr>:! clear<cr>:call VimuxRunCommand("python3 " . expand("%"))<cr>
noremap <silent><F5> :w<cr>
                \ :call VimuxSetRunner(1)<cr>
                \ :call VimuxRunCommand("python3 " . expand("%"))<cr>
                \ :call VimuxSetRunner(2)<cr>
                \ :call VimuxRunCommand("python3 -m pytest")<cr>
" map <silent><F6> :w<cr>:! clear<cr>:call VimuxRunCommand("python3 -m pudb.run " . expand("%"))<cr>
" map <silent><F6> :w<cr>:! clear<cr>:call VimuxRunCommand("python2 " . expand("%"))<cr>
map <silent><F6> :w<cr>:! clear<cr>:call VimuxSetRunner(1)<cr>:call VimuxRunCommand("python3 -m pudb.run " . expand("%"))<cr>
noremap <silent><leader>ll :w<cr>
               \ :call VimuxSetRunner(1)<cr>
               \ :call VimuxRunCommand("clear")<cr>
               \ :call VimuxRunCommand("python3 " . expand("%"))<cr>
" special key bindings for python3.7 on the t440p
if g:hostname == "ThinkPad.local.tobias-weiss.org"
noremap <silent><F5> :w<cr>
               \ :call VimuxSetRunner(1)<cr>
               \ :call VimuxRunCommand("clear")<cr>
               \ :call VimuxRunCommand("python3 " . expand("%"))<cr>
               \ :call VimuxSetRunner(2)<cr>
               \ :call VimuxRunCommand("clear")<cr>
               \ :call VimuxRunCommand("python3 -m pytest")<cr>
map <silent><F6> :w<cr>:! clear<cr>:call VimuxSetRunner(1)<cr>:call VimuxRunCommand("python3.7 -m pudb.run " . expand("%"))<cr>
noremap <silent><leader>ll :w<cr>
               \ :call VimuxSetRunner(1)<cr>
               \ :call VimuxRunCommand("clear")<cr>
               \ :call VimuxRunCommand("python3.7 " . expand("%"))<cr>
               "\ :call VimuxSetRunner(2)<cr>
               "\ :call VimuxRunCommand("clear")<cr>
               "\ :call VimuxRunCommand("python3 -m pytest")<cr>
endif

" Vimux settings
let g:VimuxOrientation = "h"
let g:VimuxHeight = "50"

" set python mode to python3 for python-mode
let g:pymode_python = 'python3'
let g:pymode_options = 1
let g:pymode_folding = 0
let g:pymode_quickfix_minheight = 3
let g:pymode_quickfix_maxheight = 6
let g:pymode_doc = 1
let g:pymode_syntax_all = 1

" neoformat
let g:neoformat_python_autopep8 = {
            \ 'exe': 'autopep8',
            \ 'args': [],
            \ 'replace': 1,
            \ 'stdin': 1,
            \ 'env': ["DEBUG=1"],
            \ 'valid_exit_codes': [0, 23],
            \ 'no_append': 1,
            \ 
let g:neoformat_enabled_python = ['autopep8', 'yapf', 'docformatter']
let g:neoformat_run_all_formatters = 1
"let g:neoformat_verbose = 1 " only affects the verbosity of Neoformat
"let &verbose            = 1 " also increases verbosity of the editor as a
"


