" Map compilation of actual file
map <F5> :! clear && g++ -std=c++17 -Wall -g % -o %:r<cr>:call VimuxRunCommand("./" . expand("%:r"))<cr>
