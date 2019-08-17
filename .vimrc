""" VUNDLE
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Plugins session:
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'joshdick/onedark.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-commentary'

" ruby/rails plugins
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-bundler'

" completition / snippets
Plugin 'ervandew/supertab'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" File search
Plugin 'rking/ag.vim'

call vundle#end()
""""
" avoid typos when executing commands
cab Q! q!
cab Q q
cab W w
cab Wq wq
cab wQ wq
cab WQ wq

" avoid the extra 'shift' keypress when typing the colon to go to cmdline mode
map ; :
" press semicolon twice in insert mode to go to normal mode
inoremap ;; <ESC>l

" Leader
let mapleader = " "

set backspace=2           " Backspace deletes like most programs in insert mode
set ruler                 " show the cursor position all the time
set showcmd               " display incomplete commands
set laststatus=2          " Always display the status line
set autowrite             " Automatically :write before running commands
set cursorcolumn          " highlight column
set ic                    " search case insensitive
set bg=dark               " dark terminal
set mouse=a               " enable mouse
set vb t_vb=              " disable all bells.
set confirm               " Y-N-C prompt if closing with unsaved changes.
set smarttab              " Handle tabs more intelligently
set hlsearch              " Highlight searches by default.
set incsearch             " Incrementally search while typing a /regex
set nowrap                " avoid wrap
" set cursorline          " highlight current line
set clipboard=unnamedplus " copy selection to clipboard

set shiftround
set expandtab
set softtabstop=-1 " Make 'softtabstop' follow 'shiftwidth'
set shiftwidth=0   " Make 'shiftwidth' follow 'tabstop'

" Softtabs, 2 spaces
function! SetTabSize(size)
    let tabsize=a:size
    let &tabstop=tabsize " Assign 'tabstop' a value of local tabsize variable
    " convert spaces to tabs when reading file
    " autocmd! bufreadpost * set noexpandtab | retab! tabsize
    " " convert tabs to spaces before writing file
    " autocmd! bufwritepre * set expandtab | retab! tabsize
    " " convert spaces to tabs after writing file (to show guides again)
    " autocmd! bufwritepost * set noexpandtab | retab! tabsize
endfunction
command! -nargs=1 SetTabSize call SetTabSize(<f-args>)
call SetTabSize(2)

" returns true if is NERDTree open/active
function! IsNTOpen()
    return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" calls NERDTreeFind if NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
function! SyncTree()
    if &modifiable && IsNTOpen() && strlen(expand('%')) > 0 && !&diff
      NERDTreeFind
      wincmd p
      normal zz
    endif
endfunction

" autocmd BufEnter * call SyncTree()

" Display extra whitespace
set list
if has("patch-7.4.710")
    set listchars=tab:\|\·,trail:·,nbsp:·,space:·
else
    set listchars=tab:\|\·,trail:·,nbsp:·
endif

" Make it obvious where 99 characters is
set textwidth=99
set colorcolumn=+1

" Numbers
set relativenumber
set number
set numberwidth=5

" NERDTree configs
autocmd vimenter * NERDTree
autocmd VimEnter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" avoid buffer changes when nerdtree focused
autocmd FileType nerdtree nnoremap <buffer> <tab> <nop>
autocmd FileType nerdtree nnoremap <buffer> <s-tab> <nop>

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
let g:airline#extensions#hunks#enabled = 1

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
nnoremap <leader>t :enew<cr>
" This replicates the idea of closing a tab
nnoremap <leader>bq :bp <BAR> bd #<CR>
" change between buffer tabs
nnoremap <tab> :bnext<CR>
nnoremap <s-tab> :bprev<CR>

" always show minibuffer explorer
" let g:miniBufExplBuffersNeeded = 0

" Avoid ctrl-i ctrl-o going to nerdtree
let g:netrw_altfile = 1

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
" set splitbelow
" set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" nnoremap <silent> <A-Up> :wincmd k<CR>
" nnoremap <silent> <A-Down> :wincmd j<CR>
" nnoremap <silent> <A-Left> :wincmd h<CR>
" nnoremap <silent> <A-Right> :wincmd l<CR>

" clean highlighted search
nnoremap ,/ :nohlsearch<CR>

" copy selection to clipboard
vnoremap <leader>y "*y<CR>

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
nnoremap <leader>k :set list!<CR>

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

