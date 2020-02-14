" Notes {{{
" vim: set tw=0 fdm=marker fdl=99:

" Personal .vimrc file of Xuekai Niu <xuekai.niu@gmail.com>, last modified at 2017-05.
" }}}

" Environment {{{
" Identify platform {{{
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif
" }}}

" Basic {{{
set nocompatible                        " Must be first
" }}}

" Platform compatible {{{
if g:os == "Windows"
    " On windows, also use '.vim' instead of 'vimfiles'; this makes sync across systems easier
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
elseif g:os == "Darwin"
    " Settings for mac
elseif g:os == "Linux"
    " Settings for linux
endif
" }}}
" }}}

" Vundle {{{
if isdirectory(expand("~/.vim/bundle/Vundle.vim/"))
    set nocompatible                    " Be improved, required
    filetype off                        " Required

    " Set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    " Alternatively, pass a path where Vundle should install plugins
    "call vundle#begin('~/some/path/here')

    " Let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'

    " Colorschemes
    Plugin 'altercation/vim-colors-solarized'

    " Status line enhanced
    Plugin 'bling/vim-airline'

    " A much simpler way to use some motions
    Plugin 'Lokaltog/vim-easymotion'

    " An easy way to edit surroundings in pairs
    Plugin 'tpope/vim-surround'
    " Repeat command enhanced, support for 'vim-surround'
    Plugin 'tpope/vim-repeat'

    " Search for the current selection
    Plugin 'nelstrom/vim-visual-star-search'

    " Quick comments
    Plugin 'scrooloose/nerdcommenter'
    " A better file explorer
    Plugin 'scrooloose/nerdtree'

    " Fuzzy file finder for vim
    Plugin 'kien/ctrlp.vim'

    " All of your Plugins must be added before the following line
    call vundle#end()                   " Required
    filetype plugin indent on           " Required
endif
" }}}

" General {{{
filetype plugin indent on               " Auto detect filetype
syntax on                               " Enable syntax

set mouse=a                             " Auto enable mouse usage

set history=2000                        " Store a ton of history

set autoread                            " Autoread file when changing outside
set hidden                              " Changing buffer needn't save first

set encoding=utf-8                      " New file with utf-8 encoding

" Auto detect encoding with this order
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" Auto reload vimrc after it changes
autocmd! bufwritepost .vimrc source $HOME/.vimrc

" Auto switch to the current file directory
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
" }}}

" Vim UI {{{
" Make GUI concise, set the initial windows size and font
if has("gui_running")
    set guioptions=                     " Simple is best
    set lines=999
    set columns=156
    if g:os == "Windows"
        set guifont=Consolas:h10:cANSI
        set guifontwide=NSimSun:h10:cGB2312
    elseif g:os == "Linux"
        set guifont=Monaco:h10:cANSI
    endif
endif

" Set colorscheme in order
if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
    set background=dark
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    colorscheme solarized
else
    colorscheme desert
endif

set number                              " Show line numbers

set shortmess=atI                       " Abbrev of messages(avoids 'hit enter')
set ruler                               " Show position
set showcmd                             " Show partial commands in status line
set wildmenu                            " Show command list instead of just completing
set wildmode=list:longest,full          " Command <Tab> completion, list matches, then longest common part, then all
set laststatus=2                        " Always show status line

set hlsearch                            " Highlight search terms
set incsearch                           " Find as you type search
set ignorecase                          " Case insensitive search
set smartcase                           " Case sensitive when uc present

set nowrap                              " Don't wrap long lines for display

set foldenable                          " Auto fold code
set foldmethod=syntax                   " Fold by syntax
set foldlevelstart=99                   " When open a buffer, don't fold at first
" }}}

" Formatting {{{
set tabstop=4                           " <Tab> shows four columns
set shiftwidth=4                        " Indent with 4 spaces
set smarttab                            " Backspace remove 4 spaces at begin of line
set expandtab                           " Always use spaces instead of tab

set autoindent                          " Indent at the same level of the previous line
set cindent                             " C language indent
set cinoptions=:0g0t0                   " Some specific congifuration of c indent

set backspace=indent,eol,start          " Backspace for dummies
set whichwrap+=<,>,[,]                  " Cursor keys wrap too
set formatoptions+=mB                   " Wrap at muti-byte char above 255, join muti-byte char without space
" }}}

" Mappings {{{
" Use ',' as map leader(default '\')
let mapleader = ","
" Then for line-search reverse, use '\' instead
noremap \ ,

" Fast editing of the vimrc
map <silent> <leader>e :e $HOME/.vimrc<cr>

" Strip trailing whitespace
map <silent> <leader>st :call StripTrailings()<cr>

" Let <ctrl-l> can also hide current highlights
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Move on display lines better
noremap <c-j> gj
noremap <c-k> gk
noremap <down> gj
noremap <up> gk
inoremap <down> <c-o>gj
inoremap <up> <c-o>gk

" Let command-line <c-p>/<c-n> search history better
cnoremap <c-p> <up>
cnoremap <c-n> <down>

" Move between buffers better
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" Switch of 'paste' option
set pastetoggle=<F5>                   " Better than map, can be used in insert mode
" }}}

" Plugins {{{
" NERDtree {{{
if isdirectory(expand("~/.vim/bundle/nerdtree/"))
    map <leader>n :NERDTreeToggle<CR>

    " Close vim if the only window left open is a NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
endif
" }}}
" }}}

" Functions {{{
" Strip trailing whitespace {{{
function! StripTrailings()
    " save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " restore previous search, and cursor position.
    let @/=_s
    call cursor(l, c)
endfunction
" }}}
" }}}

