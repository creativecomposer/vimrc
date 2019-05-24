" use minpac to help updating plugins
packadd minpac
call minpac#init()

" minpac should update itself
call minpac#add('k-takata/minpac', {'type': 'opt'})
" ALE plugin for linting, prettifying, and auto completion
call minpac#add('w0rp/ale')
" typescript syntax
call minpac#add('HerringtonDarkholme/yats.vim')
" vue file syntax
call minpac#add('posva/vim-vue')
" fuzzy finder to open files easily
call minpac#add('junegunn/fzf')

" add package update command
command! PackUpdate call minpac#update()

" set leader key to Space
let mapleader = "\<Space>"
" shortcut to copy highlighted text to clipboard
vnoremap <Leader>c "+y
" shortcut to open the file manager window in a vertical split
nnoremap <Leader>f :20Lexplore<CR>
" shortcut to paste from clipboard
nnoremap <Leader>p "+p
" shortcut to clear previous search highlighting
nnoremap <silent> <Leader>/ :nohlsearch<CR>
" shortcut to open previous buffer
nnoremap <S-Tab> :bp<CR>
" shortcut to open next buffer
nnoremap <Tab> :bn<CR>
" shortcut to open fuzzy file finder
nnoremap <C-p> :<C-u>FZF<CR>

" enable syntax highlighting 
syntax enable 

" set tabs to have 2 spaces 
set shiftwidth=2
set tabstop=2
set softtabstop=2

" show line numbers 
set number
set relativenumber

" show cursor line
set cursorline

" re-read files modified outside vim
set autoread

" indent when moving to the next line while writing code 
set autoindent
set smartindent
filetype indent on

" expand tabs into spaces 
set expandtab

" set 4 spaces only for Python
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" do not save when switching to another buffer
set hidden

" set styles for file manager
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4

" Enable persistant undo
set undofile
set undodir=~/.local/share/nvim/undo

" Enable mouse for scrolling and resizing
set mouse=a

" Number of screen lines to keep above and below the cursor
set scrolloff=3

" terminal window shortcuts
if has('nvim') 
    " use Esc to come out of terminal mode
    tnoremap <Esc> <c-\><c-n>
    " map Ctrl-v + Esc to send Esc command to the terminal program
    tnoremap <c-v><Esc> <Esc>
    " shortcut to open terminal window
    nnoremap <m-c-k> :15new <Bar> terminal<cr>i
    " move to next split easily from terminal mode 
    tnoremap <c-w> <c-\><c-n><c-w>j
    " highlight terminal cursor in red color when in normal mode within terminal buffer 
    highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15 
endif

" Configure ALE
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_fixers = {
      \'javascript': ['prettier'],
      \'typescript': ['prettier'],
      \'vue': ['prettier'],
      \'json': ['prettier'],
      \}
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_completion_enabled = 1
