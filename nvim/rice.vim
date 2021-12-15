if (has("termguicolors"))
    set termguicolors
endif

syntax enable
colorscheme moonfly

set colorcolumn=80
set updatetime=100

set number
set relativenumber

let g:buftabline_indicators = 1

" set tabline colors
hi link BufTabLineCurrent DiffText
hi link BufTabLineActive TabLineSel

let g:indentLine_char = '▏'
let g:indentLine_conceallevel = 1

" solid color line number
hi LineNr guibg=#1c1c1c ctermbg=234 guifg=#777777
hi SignColumn guibg=#1c1c1c ctermbg=234
hi CursorLineNr guibg=#101010 ctermbg=0

" solid color background for sign color alerts
hi! MoonflyWhiteAlert guibg=#1c1c1c ctermbg=234
hi! MoonflyYellowAlert guibg=#1c1c1c ctermbg=234
hi! MoonflyCoralAlert guibg=#1c1c1c ctermbg=234
hi! MoonflyEmeraldAlert guibg=#1c1c1c ctermbg=234
hi! MoonflyPurpleAlert guibg=#1c1c1c ctermbg=234
hi! MoonflySkyAlert guibg=#1c1c1c ctermbg=234
hi! MoonflyRedAlert guibg=#1c1c1c ctermbg=234

hi QuickScopePrimary guifg=#f09479 gui=bold,underline ctermfg=8 cterm=bold,underline
hi QuickScopeSecondary guifg=#ff5189 gui=bold,underline ctermfg=8 cterm=bold,underline
