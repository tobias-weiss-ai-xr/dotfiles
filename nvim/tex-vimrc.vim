""""""" Latex specific VIM settings """""""

let g:tex_flavor = 'latex'

"autocmd BufNewFil,BufRead *.tex,*.bib noremap <buffer> <C-b> :w<cr>:new<bar>r
 \ !make<cr>:setlocal buftype=nofile<cr>:setlocal
 \bufhidden=hide<cr>:setlocal noswapfile<cr>
"autocmd BufNewFile,BufRead *.tex,*.bib imap <buffer> <C-b> <Esc><C-b>

" key bindings
nnoremap <leader>ll :VimtexCompile<cr>
inoremap <leader>ll :VimtexCompile<cr>
nnoremap <leader>lv :VimtexView<cr>
inoremap <leader>lv :VimtexView<cr>
nnoremap <leader>lc :VimtexClean<cr>
inoremap <leader>lc :VimtexClean<cr>
nnoremap <leader>lm :VimtexToggleMain<cr>
inoremap <leader>lm :VimtexToggleMain<cr>
map <leader>lt :VimtexTocToggle<cr>

" Spell checking
let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'
" setlocal spell spelllang=en
set spelllang=en,sv,de
nnoremap <silent> <leader>s :set spell!<cr>
"inoremap <silent> <leader><s> <C-O>:set spell!<cr>
nnoremap <leader>j [s
inoremap <leader>j [s
nnoremap <leader>k ]s
inoremap <leader>k ]s
inoremap <leader>k ]s

" Enable YouCompleteMe Completion
"  if !exists('g:ycm_semantic_triggers')
"    let g:ycm_semantic_triggers = {}
"  endif
"  let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme

" Disable unwanted space message
let g:syntastic_tex_lacheck_quiet_messages = { 'regex': '\Vpossible unwanted space at' }
