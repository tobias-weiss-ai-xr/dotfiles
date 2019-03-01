""""""" Latex specific VIM settings """""""
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'

autocmd BufNewFile,BufRead *.tex,*.bib noremap <buffer> <C-b> :w<cr>:new<bar>r
 \ !make<cr>:setlocal buftype=nofile<cr>:setlocal
 \bufhidden=hide<cr>:setlocal noswapfile<cr>
autocmd BufNewFile,BufRead *.tex,*.bib imap <buffer> <C-b> <Esc><C-b>
"

nnoremap <F12> :VimtexCompile
