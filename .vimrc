" Vim config

" Environment {{{

  " Identify OS {
    if !exists('g:os')
      if has('win64') || has('win32') || has('win16')
        let g:os = 'Windows'
      else
        " Get OS from uname, strip newline
        let g:os = substitute(system('uname'), '\n', '', '')
      endif
    endif
  " }

  " Basics {
    " Use Vim rather than Vi settings; Must be at beginning!
    set nocompatible
    "  Check against Windows or already-set zsh
    if g:os != 'Windows' && &shell !~? 'zsh'
      set shell=/bin/zsh    " Set shell for external commands
    endif
  " }

  " Windows Compatible
    if g:os == 'Windows'
      " `$HOME/vimfiles` -> `$HOME/.vim`; improved cross-compatability
      set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,
      \ $VIM/vimfiles/after,$HOME/.vim/after
      set shell=/bin/bash    " Windows doesn't have zsh :(
    endif

" }}}
" Plugins {{{

  " Keep Vim minimal if wanted
  if empty($VIM_NO_EXTRA)

    " Vim-plug {
      " Initialize
      call plug#begin("$HOME/.vim/plugged")

        " Async linting and make
        Plug 'neomake/neomake'
        " Autocompletion
        if has('lua')
          Plug 'Shougo/neocomplete.vim'
        endif
        " Fuzzy file search
        Plug 'ctrlpvim/ctrlp.vim',
        \ {'on': ['CtrlP', 'CtrlPMixed', 'CtrlPMRU']}
        " Visualize undo history
        Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
        " Better startup screen
        Plug 'mhinz/vim-startify'
        " Git integration
        Plug 'tpope/vim-fugitive'
        " Statusline and tabline
        Plug 'vim-airline/vim-airline'
        " Oceanic Next color scheme
        Plug 'mhartington/oceanic-next'

      " Add plugins to &runtimepath
      call plug#end()
    " }

    " NeoMake {
      " Run Neomake on write
      autocmd! BufWritePost * Neomake
    " }

    " NeoComplete {
      let g:neocomplete#enable_at_startup=1
      " Use Tab completion
      inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
      " Set minimum syntax keyword length.
      let g:neocomplete#sources#syntax#min_keyword_length=3
      " Disable NeoComplete for Python
      autocmd FileType python NeoCompleteLock
    " }

    " Vim-airline {
      let g:airline_theme='oceanicnext'
      " Display all buffers when only 1 tab is open
      let g:airline#extensions#tabline#enabled=1
    " }

    " Fugitive {
      if !empty(glob("$HOME/.vim/plugged/vim-fugitive"))
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gr :Gread<CR>
        nnoremap <silent> <leader>gw :Gwrite<CR>
        nnoremap <silent> <leader>ge :Gedit<CR>
        " Mnemonic interactive
        nnoremap <silent> <leader>gi :Git add -p %<CR>
        nnoremap <silent> <leader>gg :SignifyToggle<CR>
      endif
    " }

      " Startify {
      " No random quote or ASCII cow
      let g:startify_custom_header=['']
      " }

      " Undotree {
      " `, u` -> toggle undo tree
      nnoremap <leader>u :UndotreeToggle<CR>
      " {
  
  endif

" }}}
" Functions {{{

" }}}
" Keybindings {{{

  " Global {
    " `,` leader key
    let mapleader=','
    " `\` localleader key
    let maplocalleader='\'
    " `, fc` find merge conflict markers
    map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
    " `, motion` navigate splits
    map <leader>h :wincmd h<CR>
    map <leader>j :wincmd j<CR>
    map <leader>k :wincmd k<CR>
    map <leader>l :wincmd l<CR>
  " }

  " Insert mode {
    " `k j` exit insert mode
    inoremap kj <esc>
  " }

  " Normal mode {
    " `B` move to beginning of line
    nnoremap B ^
    " `E` move to end of line
    nnoremap E $
    " `space` toggle folds
    nnoremap <space> za

    " `, space` unhighlight searches
    nnoremap <leader><space> :nohlsearch<CR>
  " }

" }}}
" UI & UX {{{

  " Colors {
    set background=dark
    colorscheme OceanicNext
    " 256 colors support
    if v:version < 800
      set t_Co=256
    else
      if (has("termguicolors"))
        set termguicolors
      endif
    endif
  " }

  " Text {
    " Show matching [ ] { } and ( )
    set showmatch
    " x amount of time brackets flash
    set matchtime=1
    " Show line numbers
    set number
    " Highlight 80th column letter
    highlight ColumnEighty ctermfg=darkred guifg=darkred
    match ColumnEighty /\%80v/
    " Don't softwrap text
    set nowrap
    " Don't wrap in the middle of words
    set linebreak
    " Don't wrap very long lines as `@@@`
    set display+=lastline
    " Don't populate autocomplete from #include files
    set complete-=i
    " Don't use octal numbers for increments in Vim
    set nrformats-=octal
    " Prevent concatenation of whitespace
    set nojoinspaces
    if v:version > 703 || v:version == 703 && has('patch541')
      " Delete comment character when joining commented lines
      set formatoptions+=j
    endif
    " Show invisible characters
    set list
    " Assign symbols to all whitespace characters
    set listchars=tab:•\ ,trail:·,extends:…,precedes:…,nbsp:↹
    if has('syntax') && !exists('g:syntax_on')
      " Enable syntax highlighting
      syntax enable
      " Better syntax highlighting for POSIX-compliant shells
      let g:is_posix=1
    endif
  " }

  " Encoding {
    " Set the default encodings just in case $LANG isn't set
    set encoding=utf-8
    set termencoding=utf-8
    scriptencoding utf-8
  " }

  " Netrw file explorer {
    " Don't display banner
    let g:netrw_banner=0
    " Wide directory view
    let g:netrw_liststyle=2
  " }

  " Tabs & Buffers {
    " x tabs maximum
    set tabpagemax=10
    " Allow hidden buffers, don't limit to 1 file per window/split
    set hidden
    " Open new buffers in current directory
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://"
    \ | lcd %:p:h | endif
  " }

  " Splits {
    set splitright
    set splitbelow
  " }

  " Session options {
    " Do not store global and local values of a session
    set sessionoptions-=options
    " Do not store folds of  a session
    set sessionoptions-=folds
  " }

  " Statusline {
    " When running Vim with plugins
    if has('statusline') && empty($VIM_NO_EXTRA)
      " Always display statusline
      set laststatus=2
      " Display current mode
      set showmode
      " Filename
      set statusline=%<%f\
      " Options
      set statusline+=%w%h%m%r
      if !empty(glob("$HOME/.vim/plugged/vim-fugitive"))
        " Fugitive in statusline
        set statusline+=%{fugitive#statusline()}
      endif
      " Filetype
      set statusline+=\ [%{&ff}/%Y]
      " Current dir
      set statusline+=\ [%{getcwd()}]
      " Right aligned file nav info
      set statusline+=%=%-14.(%l,%c%V%)\ %p%%
    " When running Vim minimally
    else
      " Create currentmode variable
      let g:currentmode={
      \ 'n'  : 'N ',
      \ 'no' : 'N·Operator Pending ',
      \ 'v'  : 'V ',
      \ 'V'  : 'V·Line ',
      \ '' : 'V·Block ',
      \ 's'  : 'Select ',
      \ 'S'  : 'S·Line ',
      \ '' : 'S·Block ',
      \ 'i'  : 'I ',
      \ 'R'  : 'R ',
      \ 'Rv' : 'V·Replace ',
      \ 'c'  : 'Command ',
      \ 'cv' : 'Vim Ex ',
      \ 'ce' : 'Ex ',
      \ 'r'  : 'Prompt ',
      \ 'rm' : 'More ',
      \ 'r?' : 'Confirm ',
      \ '!'  : 'Shell ',
      \ 't'  : 'Terminal '
      \}
      " Always display statusline
      set laststatus=2
      " Current mode
      set statusline=[%0*\ %{toupper(g:currentmode[mode()])}]
      " Filetype
      "set statusline+=[%{&ff}/%Y]
      " Options
      set statusline+=%w%h%m%r
      " Filename
      set statusline+=[%<%f
      " Separator
      set statusline+=\ -\ 
      " Current dir
      set statusline+=%{getcwd()}]
      " Right aligned file nav info
      set statusline+=%=%-14.(Ln:%l\ Col:%c%V%)\ %p%%
    endif
  " }

  " Cmdline {
    if has('cmdline_info')
      " Show commands and selections in cmdline
      set showcmd
      " Show ruler
      set ruler
      " Supercharged ruler
      set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
    endif
  " }

  " Folding settings {
    set foldenable
    set foldlevelstart=4
    " Set deepest fold to x levels
    set foldnestmax=12
    set foldmethod=indent
  " }

  " Indentation {
    if has('autocmd')
      filetype plugin indent on  " Do language-dependent indenting
    endif
    " Indent the next line matching the previous line
    set autoindent
    " Insert spaces instead of tabs
    set expandtab
    " Display existing tabs as x amount of spaces
    set tabstop=4
    " Number of spaces per tab
    set softtabstop=4
    " Number of spaces per indent
    set shiftwidth=4
  " }

  " Search {
    " Smart-case search
    set smartcase
    " Case-insensitive search
    set ignorecase
    " Incremental search
    set incsearch
    " Highlight search results
    set hlsearch
  " }

  " Persistence {
    if has('persistent_undo')
      set undodir=$HOME/.vim/undo
      " Save undo's after file closes
      set undofile
      " Max number of undo's
      set undolevels=1000
      " number of lines to save for future undo's
      set undoreload=10000
    endif
    set backupdir=$HOME/.vim/backups
    set directory=$HOME/.vim/swaps
    " x history items
    set history=1000
  " }

  " Cursor {
    " Show a visual line on the cursor's current line
    set cursorline
    " Clear line highlight so only linenr is highlighted
    "highlight clear CursorLine
    " Keep cursor in the same place after saves
    set nostartofline
    " Allow for cursor beyond last character
    set virtualedit=onemore
  " }

  " Mouse {
    " enable using the mouse if terminal emulator
    set mouse=a
    " Hide the mouse cursor while typing
    set mousehide
  " }

  " Timeouts {
    " Time out on key combinations (but not :mappings)
    set ttimeout
    " Key timeout length
    set ttimeoutlen=100
  " }

  " Clipboard {
    " Check for minimally-built Vim versions
    if has('clipboard')
      " Use + register for copy-paste, if possible
      if has('unnamedplus')
        set clipboard=unnamed,unnamedplus
      " On MacOS and Windows, use * register for copy-paste
      else
        set clipboard=unnamed
      endif
    endif
  " }

  " Scrolling {
    " Minimum lines to keep above and below cursor
    set scrolloff=1
    " Minimum lines to keep next to cursor
    set sidescrolloff=5
    " Lines to scroll when cursor leaves screen
    set scrolljump=1
  " }

  " UI Performance {
    " Set that we have a fast terminal
    set ttyfast
    " Don't redraw vim in all situations
    set lazyredraw
  " }

  " Miscellaneous {
    " Better completion in the cmdline
    set wildmenu
    " Command <Tab> completion
    set wildmode=list:longest,full
    " Abbrev. of messages (avoids `hit enter`)
    set shortmess+=filmnrxoOtT
    " Better Unix <-> Windows compatibility
    set viewoptions=folds,options,cursor,unix,slash
    " Don't use beeps for errors
    set noerrorbells
    " Flash the screen if an error occurs
    set visualbell
    " Make backspace behave the way it does in most editors
    set backspace=indent,eol,start
    " watch for file changes and auto update
    set autoread
  " }

" }}}
" Mode line {{{

  " Explicitly enable modelines
  set modeline
  " Indent & fold vimrc properly regardless of user settings
  " Commenting out is required
  " vim: softtabstop=2 shiftwidth=2 foldmethod=marker foldlevel=0:

" }}}
