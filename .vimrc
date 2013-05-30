set enc=utf-8
set tenc=utf-8
set fenc=utf-8
set fencs=utf-8,usc-bom


if has("multi_byte") "set bomb
set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
" CJK environment detection and corresponding setting
if v:lang =~ "^zh_CN"
" Use cp936 to support GBK, euc-cn == gb2312
set encoding=cp936
set termencoding=cp936
set fileencoding=cp936
elseif v:lang =~ "^zh_TW"
" cp950, big5 or euc-tw
" Are they equal to each other?
set encoding=big5
set termencoding=big5
set fileencoding=big5
elseif v:lang =~ "^ko"
" Copied from someone's dotfile, untested
set encoding=euc-kr
set termencoding=euc-kr
set fileencoding=euc-kr
elseif v:lang =~ "^ja_JP"
" Copied from someone's dotfile, untested
set encoding=euc-jp
set termencoding=euc-jp
set fileencoding=euc-jp
endif
" Detect UTF-8 locale, and replace CJK setting if needed
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
endif
else
echoerr "Sorry, this version of (g)vim was not compiled with multi_byte"
endif
" harris add begin========================================================================

"""""""""""""""""""""""""new add begin""""""""""""""""""""""""""""""""""""""

" Sets how many lines of history VIM has to remember
set history=700

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
noremap <leader>/ ^i//<esc>
nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
nmap <leader>wq :wq!<cr>

"open current directory where the present file exist
let g:netrw_winsize = 30
nmap <silent> <leader>fe :Sexplore!<cr>

"补全功能
inoremap <C-]>             <C-X><C-]>
inoremap <C-F>             <C-X><C-F>
inoremap <C-D>             <C-X><C-D>
inoremap <C-L>             <C-X><C-L>

"hidden cmd prompt
set shortmess=at
set nomore
"set cmdheight=2

" 用空格键来开关折叠
"set foldenable
"set foldmethod=manual
"nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc':'zo')<CR>

"括号自动补全
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

"inoremap ( ()<ESC>i
"inoremap ) <c-r>=ClosePair(')')<CR>
inoremap { {<CR><CR>}<ESC>ki
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>
"inoremap < <><ESC>i
"inoremap > <c-r>=ClosePair('>')<CR>
"inoremap " ""<ESC>i
inoremap ' ''<ESC>i
"buffer list
nmap bn :bn<CR><cr>
nmap bp :bp<CR><cr>
"nmap bd :bd<CR> //dangerous

"pathogen
source ~/.vim/bundle/pathogen.vim/plugin/pathogen.vim
call pathogen#infect()
call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()

"tag-bar
let tagbar_left=1
let g:tagbar_width = 40
let g:tagbar_autofocus = 0
autocmd VimEnter * nested :call tagbar#autoopen(1)
nmap <F4> :TagbarToggle<CR>

"NERD Tree
let NERDChristmasTree=1
let NERDTreeAutoCenter=1
"let NERDTreeBookmarksFile='~/.vim/NerdBookmarks.txt'
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeWinPos='left'
let NERDTreeWinSize=31
"nnoremap <F2> :NERDTreeToggle ./<CR>
"map <leader>d :execute 'NERDTreeToggle' . getcwd()<CR>
silent! nmap <C-p> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>
let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F5>"

"code complete
"let g:completekey="<leader><Space>"
"""""""""""""""""""""""""new add end""""""""""""""""""""""""""""""""""""""
"Fast reloading of the .vimrc
"map <silent> <leader>ss :source ~/.vimrc<cr>
"Fast editing of .vimrc
map <silent> <leader>ee :e ~/.vimrc<cr>
"When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

set helplang=cn
set nowrapscan

"set encoding=utf-8
syntax enable
syntax on
colorscheme desert

"ctags
set tags=tags

"lookupfile
let g:LookupFile_MinPatLength = 2               "最少输入2个字符才开始查找
let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
nnoremap <silent> <leader>lk :LookupFile<cr>
"nmap <unique> <silent> <leader>lk <Plug>LookupFile
imap <unique> <expr> <silent> <leader>lk (pumvisible()?”\<C-E>”:”").”\<Esc>\<Plug>LookupFile”
nmap <silent> <leader>ll :LUBufs<cr>
nmap <silent> <leader>lw :LUWalk<cr>
if filereadable("./filenametags")                "设置tag文件的名字
    let g:LookupFile_TagExpr = '"./filenametags"'
endif

"set autochdir

"taglist
let Tlist_Show_One_File=1
let Tlist_OnlyWindow=1
let Tlist_Use_Right_Window=0
let Tlist_Sort_Type='name'
let Tlist_Show_Menu=1
let Tlist_Max_Submenu_Items=10
let Tlist_Max_Tag_length=20
let Tlist_Use_SingleClick=1
let Tlist_Auto_Open=0
let Tlist_Close_On_Select=0
let Tlist_File_Fold_Auto_Close=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Process_File_Always=1
let Tlist_WinHeight=10
let Tlist_WinWidth=28
let Tlist_Use_Horiz_Window=0
let Tlist_Exit_OnlyWindow=0
"map <F4> :TlistToggle<CR>

"window manager
"FileExplorer
let g:winManagerWindowLayout = "BufExplorer"
let g:winManagerWidth = 40
let g:winManagerHeight = 50
let g:defaultExplorer = 0
"map <silent><leader>wm :WMToggle<cr>
"let g:winManagerWindowLayout = "BufExplorer|TagList"
"let g:winManagerWindowLayout = "BufExplorer|TagList"
"let g:winManagerWindowLayout = "BufExplorer|TagList"
nmap <C-W><C-F> :FirstExplorerWindow<cr>
nmap <C-W><C-B> :BottomExplorerWindow<cr>
let g:persistentBehaviour=0

"quickfix window
nmap cwl :cw<cr>
nmap ccl :ccl<cr>
nnoremap <F2> :buffers<CR>:buffer<Space>
"nmap <F5> :BufExplorer<cr>
nmap <F6> :cn<cr>
nmap <F7> :cp<cr>


"Cscope
set cscopequickfix=s-!,c-,d-,i-,t-,e-
"nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
"nmap <F3> :strftime("%Y_%m_%d-%H:%M"<CR>
iab xdate <c-r>=strftime("20%y/%m/%d")<cr>

" Enable filetype plugins
"set nocp
filetype on
filetype plugin on
filetype indent on
filetype plugin indent on

"tab width
set shiftwidth=4
set tabstop=4
set expandtab
set softtabstop=4

"set fdm=syntax

":abbr cdel #ifndef VENDOR_EDIT<CR>
"            \//zhiquan.huang@MMApp.Camera, xdate, Remove for reason
"            \<CR>
"            \/*<CR>
"            \<CR>
"            \*/<CR>
"            \#endif /* \VENDOR_EDIT */



"nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
let g:winword = "hello"
map ch :call Cppsearch()<cr> 
function! Cppsearch()
    let wincursor = line(".")
    let g:winword=expand("<cword>")
    "cs find s g:winword<cr>
    execute "normal! cs find s CamAdapter\r\r"
    "call setline(wincursor, "")
    "call append(wincursor+1, g:winword)
endfunction

map cx :call Cppsearch1()<cr> 
function! Cppsearch1()
    let wincursor = line(".")
    call setline(wincursor, "")
    call append(wincursor+1, g:winword)
endfunction

map cadd :call Cppadd()<cr>
function! Cppadd()
    let wincursor = line(".")
    call setline(wincursor, "")
    call append(wincursor, "#ifdef VENDOR_EDIT")
    call append(wincursor+1, "//zhiquan.huang@MMApp.Camera, ".strftime("%Y-%m-%d")." Add for yv12 postview resize")
    call append(wincursor+2, "#endif /* VENDOR_EDIT */")
    call append(wincursor+3, "")
endfunction

map cmod :call Cppmod()<cr>
function! Cppmod()
    let wincursor = line(".")
    call setline(wincursor,"#ifndef VENDOR_EDIT")
    call append(wincursor, "//zhiquan.huang@MMApp.Camera, ".strftime("%Y-%m-%d")." Modify for reason")
    call append(wincursor+1, "#else /* VENDOR_EDIT */")
    call append(wincursor+2, "#endif /* VENDOR_EDIT */")
    call append(wincursor+3, "")
endfunction

map cdel :call Cppdel()<cr>
function! Cppdel()
    let wincursor = line(".")
    call setline(wincursor, "")
    call append(wincursor, "#ifndef VENDOR_EDIT")
    call append(wincursor+1, "//zhiquan.huang@MMApp.Camera, ".strftime("%Y-%m-%d")." Remove for reason")
    call append(wincursor+2, "#endif /* VENDOR_EDIT */")
    call append(wincursor+3, "")
endfunction

map cstack :call Cppstack()<cr>
function! Cppstack()
    let wincursor = line(".")
    call append(wincursor, "")
    call append(wincursor+1, "LOGW(\"print camerastack\");")
    call append(wincursor+2, "android::CallStack camerastack;")
    call append(wincursor+3, "camerastack\.update(1, 100);")
    call append(wincursor+4, "camerastack\.dump(\"\");")
    call append(wincursor+5, "")
endfunction

map cbk:call Cppbook()<cr>
function! Cppbook()
    let wincursor = line(".")
    call setline(wincursor, "")
    call append(wincursor, "huangbookmark why")
endfunction


map xadd :call Xmladd()<cr>
function! Xmladd()
    let wincursor = line(".")
    call setline(wincursor, "")
    call append(wincursor, "<!-- #ifdef VENDOR_EDIT-->")
    call append(wincursor+1, "<!-- zhiquan.huang@MMApp.Camera, ".strftime("%Y-%m-%d")." Add for reason-->")
    call append(wincursor+2, "<!-- #endif VENDOR_EDIT-->")
    call append(wincursor+3, "")
endfunction
"au FileType c,cpp setlocal comments-=:// comments-=:/**/  comments+=f://
"au FileType c,cpp setlocal comments=sO:*/ -,mO:*/ / ,exO:*/,s1:/*
"autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" harris add end========================================================================
"
"BufExplorer
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 40  " Split width
let g:bufExplorerUseCurrentWindow=1  " Open in new window.
let g:bufExplorerMinHeight = 200
let g:bufExplorerSortBy = 'name'
augroup buf_opt
    autocmd!
    autocmd BufWinEnter \[Buf\ List\] setl nonumber
augroup END

" Smart way to move between windows
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l
"
let g:indent_guides_guide_size=1

"move lines around from vimwiki
"nnoremap <S-j> :m .+1<CR>==
"nnoremap <S-k> :m .-2<CR>==
"inoremap <S-j> <Esc>:m .+1<CR>==gi
"inoremap <S-k> <Esc>:m .-2<CR>==gi
"vnoremap <S-j> :m '>+1<CR>gv=gv
"vnoremap <S-k> :m '<-2<CR>gv=gv

set nu
set autoindent
set hlsearch
set incsearch
set showcmd
set ignorecase
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P


"add any database in current directory
if filereadable("cscope.out")
   cs add cscope.out
" else add database pointed to by environment
elseif $CSCOPE_DB != ""
   cs add $CSCOPE_DB
endif

set nocompatible
"set relativenumber
set cursorline
set laststatus=2
set wrap
set textwidth=78
set formatoptions=qrnl
"set colorcolumn=85

"set undofile
set gdefault
set modelines=0
set autowrite
set autowriteall
set autoread

"nnoremap <leader><space> :noh<cr>

"nnoremap <up> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"nnoremap <down> <nop>
"inoremap <up> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
"inoremap <down> <nop>
map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>

"nnoremap <leader>v <C-w>v
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap ; :

"use sane regexes
nnoremap / /\v
vnoremap / /\v

nnoremap <silent> <F5> : YRShow<cr>
inoremap <silent> <F5> <esc>: YRShow<cr>
inoremap <F1> <esc>
nnoremap <F1> <esc>
vnoremap <F1> <esc>
"nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<CR>''
nnoremap <leader>l yypVr=
"nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
"nnoremap <leader>r yypVr=
nnoremap <leader>r :RainbowParenthesesLoadBraces<cr>
"au FocusLost *:wa
silent! call repeat#set("\<Plug>MyWonderfulMap",v:count)

nmap tn <C-w>hj<CR>
nmap tb <C-w>hk<CR>

"make sure vim returns to the same line when you reopen a file
augroup line_return
    au!
    au BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \     execute 'normal! g`"zvzz' |
                \ endif
augroup END

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Split line (sister to [J]oin lines)
" The normal use of S is covered by ccso don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w'

"runtime macros/matchit.vim
"map    <tab> %

"made D behave
nnoremap D d$

" Heresy
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A

 "already moves to "last place you exited insert mode"so we'll map gI to
 " something similar: move to last change
nnoremap gI `.'

highlight SpellErrors  guibg=Red guifg=Black
highlight SpellErrors ctermfg=Red guifg=Red cterm=underline gui=underline term=reverse
"nnoremap <F9> :s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g<CR>
"vnoremap <F9> :s/\%V\(\w\)\(\w*\)\%V/\u\1\L\2/g<CR>
"nnoremap <F8> guw
"nnoremap <F10> gUw
nmap <F8> :A<CR>

"superTab
let g:SuperTabRetainCompletionType = 2
let g:SuperTabDefaultCompletionType = "<C-X><C-N>"
set completeopt=longest,menu
nnoremap ,cd :cd %:p:h<CR>

"map <silent> <F12> :TagbarToggle<cr> :WMToggle<cr> :wincmd h<CR>

function! IsTagBarEnabled()
    return (bufwinnr('__Tagbar__') != -1)
endfunction

function! IsBufEnabled()
    return (bufwinnr('\[Buf\ List\]') != -1)
    "return (bufwinnr('BufExplorer') != -1)
endfunction

map <F12> :call ShowSlidebar()<cr>
function! ShowSlidebar()
    if IsTagBarEnabled()
        exec "TagbarToggle"
        exec "WMToggle"
        return
    elseif IsBufEnabled()
        exec "WMToggle"
        exec "TagbarToggle"
        return
    else
        exec "TagbarToggle"
        return
    endif
endfunction


onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! f)vi(<cr>
onoremap ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
