function! Source(filename)
    let fullPath = stdpath('config') . '/' . a:filename . '.vim'
    exec 'source ' . fullPath
endfunction

call Source('plug') " Plugin installation
call Source('rice') " Color scheme, status bar, etc.
call Source('keys') " Basic keybinds
call Source('comp') " Completion-based configuration
call Source('plugs/fzf') " FZF bindings
call Source('plugs/vim-kitty-navigator') " Meta + hjkl to navigate
call Source('plugs/vimtex') " LaTeX
