" set leader
nnoremap s <Nop>
let mapleader = 's'

" zshrc in vim
set shellcmdflag=-ic

" tabs to 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4

" buffer traversal
nnoremap <leader>n :bn<CR>
nnoremap <leader>N :bp<CR>
nnoremap <leader>b :e#<CR>
nnoremap <leader>d :bp\|bd #<CR>

" paste from keyboard
vnoremap <leader>y "+y
nnoremap <leader>y "+y

nnoremap <leader>p "+p
nnoremap <leader>P "+P

" better indentation
vnoremap < <gv
vnoremap > >gv

" better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" whitespace removal with sw
nnoremap <silent> <leader>w :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" easy align
xmap <leader>a <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)
let g:easy_align_delimiters = {
    \ '(': { 'pattern': '(', 'left_margin': 2, 'right_margin': 0, 'stick_to_left': 0 }
    \ }
