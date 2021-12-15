call plug#begin(stdpath('data') . '/plugged')

" Rice
Plug 'bluz71/vim-moonfly-colors'
Plug 'bluz71/vim-moonfly-statusline'
Plug 'ap/vim-buftabline'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'

" Utility
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'knubie/vim-kitty-navigator'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'airblade/vim-rooter'
Plug 'unblevable/quick-scope'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-easy-align'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Syntax
Plug 'fladson/vim-kitty'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'vim-python/python-syntax'
Plug 'nachumk/systemverilog.vim'
Plug 'lervag/vimtex'
Plug 'sheerun/vim-polyglot'

call plug#end()
