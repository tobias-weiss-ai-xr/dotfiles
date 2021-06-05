" Latex specific vim settings (double as also defined in init)
let g:tex_flavor = 'latex'

" Disable colorcolumn
set colorcolumn =

" Change MatchParen color
hi MatchParen ctermbg=5

"tex specific folding
set foldmethod=expr
set foldexpr=vimtex#fold#level(v:lnum)
set foldtext=vimtex#fold#text()
set fillchars=fold:\

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
nnoremap <leader>ls :VimtexToggleMain<cr>
inoremap <leader>ls :VimtexToggleMain<cr>
nnoremap <leader>le :VimtexError<cr>
inoremap <leader>le :VimtexError<cr>
" mapped below
"map <leader>lt :VimtexTocToggle<cr>

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

" syntastic settings
let g:syntastic_tex_checkers =  ['lacheck', 'text/language_check']
"let g:syntastic_tex_checkers =  ['lacheck', 'chktex', 'text/language_check', 'proselint']

" Disable unwanted syntastic message
let g:syntastic_tex_lacheck_quiet_messages = { 'regex': [
            \ '\Vmissing',
            \ '\Vpossible unwanted space',
            \ '\Vperhaps you should insert a'] }

let g:syntastic_tex_chktex_quiet_messages = { 'regex': [
            \ '\VWrong length of dash', 
            \ '\VCommand terminated with space',
            \ '\VInterword spacing',
            \ '\VUse either',
            \ '\VIntersentence spacing',
            \ '\VNon-breaking space', 
            \ '\VDelete this space to maintain correct pagereferences.']}

" TOC settings
" https://github.com/lervag/vimtex/issues/1124
  augroup vimtex_customization
    autocmd!
    autocmd FileType tex call CreateTocs()
  augroup END

  function CreateTocs()
    let g:custom_toc1 = vimtex#toc#new({
			\ 'name' : 'TOC',
			\ 'layers' : ['content', 'todo', 'include'],
			\ 'resize' : 1,
			\ 'split_width' : 50,
			\ 'todo_sorted' : 0,
			\ 'show_help' : 1,
			\ 'show_numbers' : 1,
			\ 'mode' : 2,
			\})
    nnoremap <leader>lt :call g:custom_toc1.open()<cr>
    let g:custom_toc2 = vimtex#toc#new({
            \ 'layers' : ['todo'],
            \ 'show_help' : 0,
            \})
    nnoremap <leader>lT :call g:custom_toc2.open()<cr>
  endfunction

"let g:vimtex_toc_config = {
"			\ 'name' : 'TOC',
"			\ 'layers' : ['content', 'todo', 'include'],
"			\ 'resize' : 1,
"			\ 'split_width' : 50,
"			\ 'todo_sorted' : 0,
"			\ 'show_help' : 1,
"			\ 'show_numbers' : 1,
"			\ 'mode' : 2,
"			\}

" Disable custom QuickFix warnings based on regexp
let g:vimtex_quickfix_ignore_filters = [
      \ 'Marginpar on page',
      \ 'Overfull',
      \ 'Underfull',
      \ 'Using fall-back BibTeX(8) backend',
      \ 'running in backwards compatibility mode',
      \ 'float specifier changed',
      \ 'Package caption Warning',
      \ 'sortcites',
      \]

let g:vimtex_compiler_latexmk = {
			\ 'backend' : 'nvim',
			\ 'background' : 1,
			\ 'build_dir' : '',
			\ 'callback' : 1,
			\ 'continuous' : 1,
			\ 'executable' : 'latexmk',
			\ 'hooks' : [''],
			\ 'options' : [
			\   '-verbose',
			\   '-file-line-error',
			\   '-interaction=nonstopmode',
			\   '-synctex=1',
			\ ],
			\}
