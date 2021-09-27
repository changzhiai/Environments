set backspace=indent,eol,start
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

call plug#begin()

""a file system explorer
Plug 'preservim/nerdtree'
"autocmd vimenter * NERDTree
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>

""a colorscheme 
"call plug#begin()
""Plug 'altercation/vim-colors-solarized'
"call plug#end()
""syntax enable
"set background=dark
""colorscheme solarized

""a comment functions
Plug 'preservim/nerdcommenter'
let g:mapleader = ","

""insert completion
Plug 'ervandew/supertab'

""syntax checking
"Plug 'vim-syntastic/syntastic'
""set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
""set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
""let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
""let g:syntastic_check_on_wq = 0

""syntax checking
Plug 'dense-analysis/ale'
let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {'python': ['black']}
"let g:ale_fixers = {
"\    '*': ['remove_trailing_lines', 'trim_whitespace'],
"\    'python': ['black']
"\}
"let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 0 "do not check while entering
nmap <F7> :ALEToggle<CR>
nmap <F10> :ALEFix<CR>
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)

""punctuation complement
Plug 'jiangmiao/auto-pairs'

call plug#end()

""indent line setting
let g:indentLine_defaultGroup = 'SpecialKey'
"let g:indentLine_color_term = 239

