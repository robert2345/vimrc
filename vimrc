"
" Personal preference .vimrc file
" Maintained by Vincent Driessen <vincent@datafox.nl>
"
" My personally preferred version of vim is the one with the "big" feature
" set, in addition to the following configure options:
"
"     ./configure --with-features=BIG
"                 --enable-pythoninterp --enable-rubyinterp
"                 --enable-enablemultibyte --enable-gui=no --with-x --enable-cscope
"                 --with-compiledby="Vincent Driessen <vincent@datafox.nl>"
"                 --prefix=/usr
"
" To start vim without using this .vimrc file, use:
"     vim -u NORC
"
" To start vim without loading any .vimrc or plugins, use:
"     vim -u NONE
"

" Use vim settings, rather then vi settings (much better!)
" This must be first, because it changes other options as a side effect.
set nocompatible



"Highlight active window by drawin a red line in column 80
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set colorcolumn=80
    autocmd WinLeave * set colorcolumn=0
augroup END

set showcmd

"Use space as leader key
let mapleader = " "
let g:ycm_server_python_interpreter = '/usr/bin/python2'
nnoremap <F5> :YcmForceCompileAndDiagnostics <CR>
nnoremap <Leader>dd :YcmShowDetailedDiagnostic <CR>
nnoremap <Leader>d :YcmDiags <CR>
"nnoremap <Leader>g :YcmCompleter GoToDeclaration<CR>
"nnoremap <Leader>gg :YcmCompleter GoToDefinition<CR>

"noremap <Leader>ri :call rtags#SymbolInfo()<CR>
"noremap <Leader>g :call rtags#JumpTo()<CR>
"noremap <Leader>rS :call rtags#JumpTo(" ")<CR>
"noremap <Leader>rV :call rtags#JumpTo("vert")<CR>
"noremap <Leader>rT :call rtags#JumpTo("tab")<CR>
"noremap <Leader>gg :call rtags#JumpToParent()<CR>
noremap <Leader>r :call rtags#FindRefs()<CR>
noremap <Leader>g :call rtags#JumpTo(g:SAME_WINDOW)<CR>
noremap <Leader>gg :call rtags#JumpTo(g:SAME_WINDOW, { '--declaration-only' : '' })<CR>
"noremap <Leader>rn :call rtags#FindRefsByName(input("Pattern? ", "", "customlist,rtags#CompleteSymbols"))<CR>
"noremap <Leader>rs :call rtags#FindSymbols(input("Pattern? ", "", "customlist,rtags#CompleteSymbols"))<CR>
noremap <Leader>ri :call rtags#ReindexFile()<CR>
noremap <Leader>rl :call rtags#ProjectList()<CR>
"noremap <Leader>rw :call rtags#RenameSymbolUnderCursor()<CR>
"noremap <Leader>rv :call rtags#FindVirtuals()<CR>
noremap <Leader>t :call rtags#FindRefsCallTree()<CR>

let g:rtagsUseDefaultMappings = 0

"Find all instances of word under curson in current package.
noremap <Leader>f yiw:!git grep <C-R>0<CR>

"set makeprg=devtool build $PACKAGE
"set makeef='ls -t ./oe-logs/log.do_compile* | head -1' "refer to the latest of the log files for compile task of this package.
"set shellpipe=2>
"set errorformat=%A%f:%l:\ %m,%C%m "Check this. Just copied from som java guide. Perhaps nog totally cool.
"noremap <M-1> :w<CR>:set ch=5<CR>:!devtool build $PACKAGE<CR>
"noremap <M-2> :cp<CR>
"noremap <M-3> :cn<CR>
"noremap <M-4> :cl<CR>



"Start NERDTree automagically
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"Toggle NERDTree
map <C-n> :NERDTreeFocus<CR>

set backspace=2
set number
syntax on

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set nowrap 


"Navigation settings.
set winwidth=20
set winminwidth=15
set winwidth=100

set winheight=6 "Make room for winminheight setting
set winminheight=5 "windows min height. stack many windows efficiently.
set winheight=999 "Make sure current window is maximized in height


"next win and maximize
nmap <C-J> <C-W>j"
"prev win and maximize
nmap <C-K> <C-W>k"

"Similarly for moving left and right, but without maximizing
nmap <c-h> <c-w>h"<c-w>
nmap <c-l> <c-w>l"<c-w>

colorscheme industry

filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
" Plugin 'shanesharper/vim-rtags'
Plugin 'lyuts/vim-rtags'
Plugin 'scrooloose/nerdtree'
"Plugin 'jeaye/color_coded'

"Colorscheme light and dar
Plugin 'nightsense/simplifysimplify'
Plugin 'fcpg/vim-farout'

"Fuzzy file search
"Plugin 'ctrlpvim/ctrlp.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

