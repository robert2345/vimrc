"
" Personal preference .vimrc file
"
" The person I borrowed this from wrote:
" personally preferred version of vim is the one with the "big" feature
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


"Highlight active window by drawin a red line in column 81
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set colorcolumn=81
    autocmd WinLeave * set colorcolumn=0
augroup END

set showcmd

set pastetoggle=<F3>

"Use space as leader key
let mapleader = " "
let g:ycm_server_python_interpreter = '/usr/bin/python2'
nnoremap <F5> :YcmForceCompileAndDiagnostics <CR>
nnoremap <Leader>dd :YcmShowDetailedDiagnostic <CR>
nnoremap <Leader>d :YcmDiags <CR>
"nnoremap <Leader>g :YcmCompleter GoToDeclaration<CR>
"nnoremap <Leader>gg :YcmCompleter GoToDefinition<CR>
"

" Use rtags for autocomplet
set completefunc=RtagsCompleteFunc
noremap <Leader>i :call rtags#SymbolInfo()<CR>
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
noremap <Leader>rw :call rtags#RenameSymbolUnderCursor()<CR>
"noremap <Leader>rv :call rtags#FindVirtuals()<CR>
noremap <Leader>t :call rtags#FindRefsCallTree()<CR>

"Yank and paste between vim sessions
noremap <Leader>y "+y<CR>
noremap <Leader>p "+p<CR>

let g:rtagsUseDefaultMappings = 0

"Find all instances of word under curson in current package.
noremap <Leader>f yiw:Ack! <C-R>0<CR>

" Simplify compliling by using the make command and refer to the error file
set makeprg=ffbuild\ --compile-only\ $PACKAGE
set makeef=$LOG_PATH/log.do_compile "refer to the latest of the log files for compile task of this package.
"Put this first of the matches so that it overrides default c style. This is
"how it will look when ninja has built the code since it referes from the
"builddirectory as set up by meson.
set errorformat^=../../../../../../workspace/sources/%*[^/]/%f:%l:%c:%m 

"build and deploy. Try to make this return as soon as it has rebooted instead
"of hanging
noremap <Leader>b :!ffbuild $PACKAGE && ffbuild --deploy root@$AXIS_TARGET_IP $PACKAGE && ssh $AXIS_TARGET_IP systemctl reboot<CR>

"build and deploy, then restart package
noremap <Leader>z :!ffbuild $PACKAGE && ffbuild --deploy root@$AXIS_TARGET_IP $PACKAGE && ssh $AXIS_TARGET_IP systemct restart $PACKAGE<CR>

"build and run check tests
"noremap <Leader>v :!ffbuild -c $PACKAGE-unittest<CR>
noremap <Leader>v :!ffbuild --sync-source -c $PACKAGE-unittest<CR>
"noremap <Leader>v :!ffbuild --sync-source --checkmem $PACKAGE-unittest<CR>

"test kernel module
"noremap <Leader>m :!cd $BUILDDIR/workspace/sources/$PACKAGE/test/ ; ./test.sh -x "overlay scale dispatcher_dewarp freeze triggered_source"<CR>
"noremap <Leader>m :!cd $BUILDDIR/workspace/sources/$PACKAGE/test/ ; ./test.sh -x "scale"<CR>
noremap <Leader>m :!cd $BUILDDIR/workspace/sources/$PACKAGE/test/ ; ./test.sh -x "overlay"<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
let g:easy_align_ignore_groups=['String']


set backspace=2
set number
syntax on

" These settings are probably overridden by the vim-sleuth plugin. The
" tabstop=8 setting has effect on how tabs are represented if project uses
" tabs for indent. This is cool.
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

set nowrap 

"Set the status bar
set laststatus=2 "Show the status bara regardless of number of open buffer


"Navigation settings.
set winwidth=20
set winminwidth=15
set winwidth=100

set winheight=6 "Make room for winminheight setting
set winminheight=5 "windows min height. stack many windows efficiently.
set winheight=999 "Make sure current window is maximized in height


"next win and maximize
nmap <C-J> <C-W>j
"prev win and maximize
nmap <C-K> <C-W>k

"Similarly for moving left and right
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l


colorscheme elflord

" enable spell checking"
set spell spelllang=en_us
" disable it cause it is annoying
set nospell

filetype on

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" This plug lets you do GIT stuff from within Vim
Plugin 'tpope/vim-fugitive'

Plugin 'tpope/vim-sleuth'

"Supposedly this should result in good autocompletion alternatives
"Plugin 'Valloric/YouCompleteMe'

"rtags use the compilation database that Bear generates, and rtags, to find stuff
Plugin 'lyuts/vim-rtags'

Plugin 'scrooloose/nerdtree'
"Plugin 'jeaye/color_coded'

"Colorscheme light and dar
"Plugin 'nightsense/simplifysimplify'
Plugin 'fcpg/vim-farout'

Plugin 'vim-scripts/DoxygenToolkit.vim'
"Plugin 'WolfgangMehner/vim-plugins'

Plugin 'junegunn/vim-easy-align'

"Fuzzy file search
Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'mileszs/ack.vim'

"Nice preconfigured status line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

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

autocmd FileType c,cpp,java,php autocmd BufWritePre <buffer> %s/\s\+$//e
