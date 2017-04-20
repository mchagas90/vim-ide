""" VUNDLE
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" My Plugins here:
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'joshdick/onedark.vim'
Plugin 'joshdick/airline-onedark.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-commentary'

" completition / snippets
Plugin 'ervandew/supertab'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" File search
" Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'

Plugin 'vim-ruby/vim-ruby'

call vundle#end()
""""
" avoid typos when executing commands
cab Q q
cab W w
cab Wq wq
cab wQ wq
cab WQ wq

" Leader
let mapleader = " "

set backspace=2   " Backspace deletes like most programs in insert mode
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
"set cursorline    " highlight current line
set cursorcolumn  " highlight column
set ic            " search case insensitive
set bg=dark       " dark terminal
set mouse=a       " enable mouse
set vb t_vb=      " disable all bells.
set confirm       " Y-N-C prompt if closing with unsaved changes.
set smarttab      " Handle tabs more intelligently
set hlsearch      " Highlight searches by default.
set incsearch     " Incrementally search while typing a /regex
set nowrap        " avoid wrap

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set listchars=tab:»·,trail:·,nbsp:·
" ,space:·

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set relativenumber
set number
set numberwidth=5

" NERDTree configs
autocmd vimenter * NERDTree
autocmd VimEnter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" enable nerdtree and tabs
map <Leader>n :NERDTreeToggle<CR>

" Switch syntax on
syntax on

colorscheme onedark
set t_Co=256
" uncomment if your terminal does not support 256 colors
" let g:onedark_termcolors=16

" custom coble the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
"show git add/edit/delet
let g:airline#extensions#hunks#enabled=1

let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1

" change buffer separator
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
"let g:airline_symbols.space = "\ua0"
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.crypt = '🔒'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇ '
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.spell = 'Ꞩ'
"let g:airline_symbols.notexists = '∄'
"let g:airline_symbols.whitespace = 'Ξ'
" powerline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''

" snipmate configs
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['ruby'] = 'ruby,rails'

" buffer config
" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
nmap <leader>t :enew<cr>

" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" change between buffer tabs
nnoremap <C-O> :bnext<CR>
nnoremap <C-I> :bprev<CR>

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.tt,*.erb set filetype=html
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

augroup END

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"Searching tools configs

"Ag config
let g:ag_working_path_mode="r"

let g:ag_highlight=1
let g:ag_prg='ag --column --nogroup --noheading'

let g:ignore_dirs = "log/ coverage/"

if exists("g:ignore_dirs")
  let g:ag_prg.=" --ignore ".join(split(g:ignore_dirs), " --ignore ")
endif

"nnoremap <C-F> :Ack<space>
"open searcher
nnoremap <leader>f :Ag!<space>
" search visual selection in all files
vnoremap <leader>d y:Ag! <C-r>=fnameescape(@")<CR><CR>
"search for text selected
vnoremap // y/<C-R>"<CR>

" set list on/off
nmap <leader>k :call SetListOnOff()<cr>
function! SetListOnOff()
    if &list
        set nolist
    else
        set list!
    endif
endfunction

" configure syntastic syntax checking to check on open as well as save
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_html_checkers=['']
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_eruby_ruby_quiet_messages =
    \ {"regex": "possibly useless use of a variable in void context"}

" Always use vertical diffs
set diffopt+=vertical

