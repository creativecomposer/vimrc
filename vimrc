" use minpac to help updating plugins
packadd minpac
call minpac#init()

" minpac should update itself
call minpac#add('k-takata/minpac', {'type': 'opt'})
" ALE plugin for linting, prettifying. Note: auto completion disabled, taken
" care by coc.nvim
call minpac#add('w0rp/ale')
" auto completion. Note: requires Node.js to work
call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
" For different language syntax files
call minpac#add('sheerun/vim-polyglot')
" fuzzy finder to open files easily
call minpac#add('junegunn/fzf', { 'do': { -> fzf#install() } })
" editorconfig plugin
call minpac#add('editorconfig/editorconfig-vim')
" one colorscheme
call minpac#add('rakr/vim-one')
" Vim fugitive plugin for git functionality
call minpac#add('https://tpope.io/vim/fugitive.git')

" add package update command
command! PackUpdate call minpac#update()

" set color
set termguicolors
" color editplus
" colors zenburn
let g:one_allow_italics = 1
color one
set background=dark

" colorscheme ron
" set guicursor=i:block-iCursor-blinkwait300-blinkon200-blinkoff150

" set leader key to Space
let mapleader = "\<Space>"
" shortcut to copy highlighted text to clipboard
vnoremap <Leader>c "+y
" shortcut to paste from clipboard
nnoremap <Leader>p "+p
" shortcut to go to definition of current word
nmap <silent> <Leader>g <Plug>(coc-definition)
" shortcut to open the references of current word
nmap <silent> <Leader>r <Plug>(coc-references)
" shortcut to clear previous search highlighting
nnoremap <silent> <Leader>/ :nohlsearch<CR>
" shortcut to open netrw file manager
nnoremap <silent> <Leader>t :Vexplore<CR>
" shortcut to open previous buffer
nnoremap <S-Tab> :bp<CR>
" shortcut to open next buffer
nnoremap <Tab> :bn<CR>
" shortcut to open fuzzy file finder
nnoremap <C-p> :<C-u>FZF<CR>
" map c-a because in macOS c-6 does not work
nnoremap <C-a> <C-^>
" move vertically by wrapped line with j and k
nnoremap j gj
nnoremap k gk

" enable syntax highlighting 
syntax enable 

" indent when moving to the next line while writing code 
set autoindent
set smartindent
filetype indent on

" set tabs to have 2 spaces 
set shiftwidth=2
set tabstop=2
set softtabstop=2

" expand tabs into spaces 
set expandtab

" set 4 spaces only for Python
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" show line numbers 
set number
set relativenumber

" show cursor line
set cursorline

" re-read files modified outside vim
set autoread

" do not save when switching to another buffer
set hidden

" Enable persistant undo
set undofile
set undodir=~/.local/share/nvim/undo

" Enable mouse for scrolling and resizing
set mouse=a

" Number of screen lines to keep above and below the cursor
set scrolloff=3

" Give more space for displaying messages
set cmdheight=2

" terminal window shortcuts
if has('nvim') 
    " use Esc to come out of terminal mode
    tnoremap <Esc> <c-\><c-n>
    " map Ctrl-v + Esc to send Esc command to the terminal program
    tnoremap <c-v><Esc> <Esc>
    " shortcut to open terminal window
    nnoremap <c-k> :15new <Bar> terminal<cr>i
    nnoremap <Leader>k :botright 70vnew <Bar> terminal<cr>i
    " move to next split easily from terminal mode 
    tnoremap <c-w> <c-\><c-n><c-w>j
    " highlight terminal cursor in red color when in normal mode within terminal buffer 
    highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15 
endif

" set styles for file manager
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 25

" Configure ALE
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_fixers = {
      \'javascript': ['prettier'],
      \'typescript': ['prettier'],
      \'vue': ['prettier'],
      \'json': ['prettier'],
      \'scss': ['prettier'],
      \'javascriptreact': ['prettier'],
      \'typescriptreact': ['prettier'],
      \'html': ['prettier']
      \}
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_disable_lsp = 1

" Configure statusline
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\[%{&fileencoding?&fileencoding:&encoding}\]
set statusline+=\ %l/%L:%c
set statusline+=\ 

" Wrap selected text with tags
function! VisualTagsWrap()
  if !exists('g:tags_to_wrap')
    let g:tags_to_wrap=[]
  endif
  let g:tags_to_wrap=split(input('space separated tags to wrap block: ', join(g:tags_to_wrap, ' ')), '\s\+')
  if len(g:tags_to_wrap)>0
    execute 'normal! `<o</'.join(reverse(g:tags_to_wrap), '></').'>'
    execute 'normal! `<O<'.join(reverse(g:tags_to_wrap), '><').'>'
  endif
endfunction

vnoremap <silent> <Leader>w <ESC>:call VisualTagsWrap()<CR>
