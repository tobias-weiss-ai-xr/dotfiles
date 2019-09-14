""""""" Latex specific VIM settings """""""

let g:tex_flavor = 'latex'

"autocmd BufNewFil,BufRead *.tex,*.bib noremap <buffer> <C-b> :w<cr>:new<bar>r
 \ !make<cr>:setlocal buftype=nofile<cr>:setlocal
 \bufhidden=hide<cr>:setlocal noswapfile<cr>
"autocmd BufNewFile,BufRead *.tex,*.bib imap <buffer> <C-b> <Esc><C-b>

map <F5> VimtexCompile<cr>
map <F6> :VimtexView<cr>
map <F7> :VimtexClean<cr>

" Spell checking
let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'
" setlocal spell spelllang=en
map <F9> [s
map <F10> ]s

" Enable YouCompleteMe Completion
  if !exists('g:ycm_semantic_triggers')                                         
    let g:ycm_semantic_triggers = {}                                            
  endif                                                                         
  let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme 

" Disable unwanted space message
let g:syntastic_tex_lacheck_quiet_messages = { 'regex': '\Vpossible unwanted space at' }
