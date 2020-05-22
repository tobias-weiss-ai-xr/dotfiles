" Latex specific vim settings (double as also defined in init)
let g:tex_flavor = 'latex'

" Disable colorcolumn
set colorcolumn =

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

" syntastic settings
" let g:syntastic_tex_checkers =  ['lacheck', 'text/language_check']
let g:syntastic_tex_checkers =  ['lacheck', 'chktex', 'text/language_check', 'proselint']

" Disable unwanted syntastic message
let g:syntastic_tex_lacheck_quiet_messages = { 'regex': [
            \ '\Vmissing',
            \ '\Vpossible unwanted space',
            \ '\Vperhaps you should insert a'] }

let g:syntastic_tex_chktex_quiet_messages = { 'regex': [
            \ '\VWrong length of dash', 
            \ '\VCommand terminated with a space',
            \ '\VInterword spacing',
            \ '\VNon-breaking space', 
            \ '\VDelete this space to maintain correct pagereferences.']}

" TOC settings
let g:vimtex_toc_config = {
			\ 'name' : 'TOC',
			\ 'layers' : ['content', 'todo', 'include'],
			\ 'resize' : 1,
			\ 'split_width' : 50,
			\ 'todo_sorted' : 0,
			\ 'show_help' : 1,
			\ 'show_numbers' : 1,
			\ 'mode' : 2,
			\}

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
			\   '-synctex=1',
			\   '-interaction=nonstopmode',
			\ ],
			\}
