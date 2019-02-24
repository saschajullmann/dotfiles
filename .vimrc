" ============================================================================
" Install Vim-PLug if it does not exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ============================================================================
" Active plugins
" You can disable or add new ones here:

call plug#begin()
" Better file browser
Plug 'scrooloose/nerdtree'
" Zen coding
Plug 'mattn/emmet-vim'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Surround
Plug 'tpope/vim-surround'
" Autoclose
Plug 'Townk/vim-autoclose'
" Async code checker/linter
Plug 'w0rp/ale'
" Paint css colors with the real color
Plug 'lilydjwg/colorizer'
" Javascript Syntax
Plug 'pangloss/vim-javascript'
" Support for React/JSX Syntax
Plug 'mxw/vim-jsx'
" Gruvbox Colorscheme
Plug 'morhetz/gruvbox'
" Git integration
Plug 'tpope/vim-fugitive'
" Git syntax highlighting
Plug 'tpope/vim-git'
" Python code formatter
Plug 'ambv/black'
" Autocompletion
Plug 'Valloric/YouCompleteMe'
" Initialize plugin system
call plug#end()

" ============================================================================
" Vim settings and mappings

" allow plugins by file type (required for plugins!)
filetype plugin on
filetype indent on

" Show file options above the command line
set wildmenu
set wildmode=list:full

" `gf` opens file under cursor in a new vertical split
nnoremap gf :vertical wincmd f<CR>

" open a new split on the right side of current buffer
set splitright

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set colorcolumn=80

" setting the colorscheme
set t_Co=256
"let g:gruvbox_italic=1
"let g:gruvbox_contrast_dark="hard"
color gruvbox

" better indendation for python
au BufNewFile,BufRead *.py:
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=88
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

" tab length exceptions on some file types
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocm FileType python setlocal colorcolumn=88

" always show status bar
set laststatus=2

" incremental search
set incsearch
" highlighted search results
set hlsearch

" syntax highlight on
syntax on

" show line numbers
set nu
set cursorline

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo
" store yankring history file there too
let g:yankring_history_dir = '~/.vim/dirs/'

" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" ============================================================================
" Plugins settings and mappings
" Edit them as you wish.

" NERDTree -----------------------------

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

"YouCompleteMe
" Point YCM to the Pipenv created virtualenv, if possible
" At first, get the output of 'pipenv --venv' command.
let pipenv_venv_path = system('pipenv --venv')
" The above system() call produces a non zero exit code whenever
" a proper virtual environment has not been found.
" So, second, we only point YCM to the virtual environment when
" the call to 'pipenv --venv' was successful.
" Remember, that 'pipenv --venv' only points to the root directory
" of the virtual environment, so we have to append a full path to
" the python executable.
if shell_error == 0
  let venv_path = substitute(pipenv_venv_path, '\n', '', '')
  let g:ycm_python_binary_path = venv_path . '/bin/python'
else
  let g:ycm_python_binary_path = 'python'
endif

" Disable the auto blacklisting of JSX files for the filepath completer
let g:ycm_filepath_blacklist = {}

" Vim-JSX ------------------------------
let g:jsx_ext_required = 0

" ALE ------------------------------
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_linters = {'python': ['flake8']}
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'always'
let g:ale_python_flake8_executable = 'pipenv'
let g:ale_python_flake8_options = ''

" Python black
autocmd BufWritePre *.py execute ':Black'

" Emmet VIM enable JSX for Javascript files
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}

" Airline ------------------------------

let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox'
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" to use fancy symbols for airline, uncomment the following lines and use a
" patched font (more info on the README.rst)
if !exists('g:airline_symbols')
   let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

"
"Inserting better -----------------------
set pastetoggle=<F10>

"Make sure webpack hot reloading works with vim ------
set backupcopy=yes
