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

" Map execution of actual file
" map <F5> :! clear & python % &
" map <F6> :! clear & python3 % &
map <silent><F5> :w<cr>:! clear<cr>:call VimuxRunCommand("python " . expand("%"))<cr>
map <silent><F6> :w<cr>:! clear<cr>:call VimuxRunCommand("python3 " . expand("%"))<cr>
nnoremap <silent><leader>ll :w<cr>:Neomake<cr> :! clear<cr>:call VimuxRunCommand("python " . expand("%"))<cr>
inoremap <silent><leader>ll :w<cr>:Neomake<cr> :! clear<cr>:call VimuxRunCommand("python " . expand("%"))<cr>

" set python mode to python3 for python-mode
let g:pymode_python = 'python3'
let g:pymode_options = 1
let g:pymode_folding = 0
let g:pymode_quickfix_minheight = 3
let g:pymode_quickfix_maxheight = 6
let g:pymode_doc = 1
let g:pymode_syntax_all = 1

