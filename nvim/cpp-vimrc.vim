" Map compilation of actual file
" map <F5> :! clear && g++ -std=c++17 -Wall -g % -o %:r<cr>:call VimuxRunCommand("./" . expand("%:r"))<cr>
map <F5> :w<cr>:! clear && clang++ -std=c++11 -Wall -Wno-c++11-extensions -g % -o %:r<cr>:call VimuxRunCommand("./" . expand("%:r"))<cr>
