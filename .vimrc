"{{{ fold config
    "set foldmarker={{{,}}}
    "set foldmethod=marker
"}}}

" Environment {{{
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
" }}}

" General {{{
    set background=dark         " Assume a dark background
    if !has('gui')
        "set term=$TERM          " Make arrow and other keys work
    endif
    filetype plugin indent on   " Automatically detect file types.
    filetype on
    filetype plugin on
    filetype indent on

    syntax on                   " Syntax highlighting
    syntax enable

    "set mouse=a                 " Automatically enable mouse usage
    "set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    if has ('x') && has ('gui') " On Linux use + register for copy-paste
        set clipboard=unnamedplus
    elseif has ('gui')          " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif

    " Most prefer to automatically switch to the current file directory when
    " a new buffer is opened; to prevent this behavior, add the following to
    " your .vimrc.bundles.local file:
    "   let g:spf13_no_autochdir = 1
    if !exists('g:spf13_no_autochdir')
        "autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
        " Always switch to the current file directory
    endif

    "set autowrite                       " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set shortmess+=atI                   " Abbrev. of messages (avoids 'hit enter')
    set nomore
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    "set spell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving
    set nocompatible
    "set relativenumber
    set wrap
    set textwidth=78
    set formatoptions=qrnl
    "set colorcolumn=85

    "set undofile
    set gdefault
    set modelines=0
    set autowrite
    set autowriteall
    set autoread            " Set to auto read when a file is changed from the outside
    set helplang=cn
    set nowrapscan
    set visualbell


    "set encoding=utf-8
    colorscheme desert

    " Setting up the directories {
    set backup                  " Backups are nice ...
    if has('persistent_undo')
        set undofile                " So is persistent undo ...
        set undolevels=1000         " Maximum number of changes that can be undone
        set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
    endif

    " To disable views add the following to your .vimrc.bundles.local file:
    " let g:spf13_no_views = 1
    if !exists('g:spf13_no_views')
        " Add exclusions to mkview and load view
        " eg: *.*, svn-commit.tmp
        let g:skipview_files = [
                    \ '\[example pattern\]'
                    \ ]
    endif
    " }

    " }}}

    " Vim UI {{{
    set showmode                    " Display the current mode
    set cursorline                  " Highlight current line
    hi CursorLine   cterm=NONE ctermbg=blue ctermfg=white guibg=blue guifg=white

    highlight clear SignColumn      " SignColumn should match background for
    " things like vim-gitgutter

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
        " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        "set statusline+=%{fugitive#statusline()} " Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set nu                          " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    "set title                       "show file's title in terminal
    set wildmenu                    " Show list instead of just completing in command mode
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    "set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
    nmap <silent> <leader>s :set nolist!<CR>    " make tabs and trailing spaces visible when requested

    "highlight SpellErrors  guibg=Red guifg=Black
    "highlight SpellErrors ctermfg=Red guifg=Red cterm=underline gui=underline term=reverse
    "set autochdir
    let g:indent_guides_guide_size=1

    "make sure vim returns to the same line when you reopen a file
    augroup line_return
        au!
        au BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \     execute 'normal! g`"zvzz' |
                    \ endif
    augroup END

    function! Mosh_Tab_Or_Complete()
        if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
            return "\<C-N>"
        else
            return "\<Tab>"
    endfunction


    inoremap <Tab> <C-R>=Mosh_Tab_Or_Complete()<CR>

    " }}}

    " Formatting {{{
        set nowrap                      " Wrap long lines
        set autoindent                  " Indent at the same level of the previous line
        set shiftwidth=4                " Use indents of 4 spaces
        set expandtab                   " Tabs are spaces, not tabs
        set tabstop=4                   " An indentation every four columns
        set softtabstop=4               " Let backspace delete indent
        "set matchpairs+=<:>             " Match, to be used with %
        "set pastetoggle==               " pastetoggle (sane indentation on pastes)
        "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
        " Remove trailing whitespaces and ^M chars
        autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()
        autocmd BufWritePre * call RemoveTrailingWhitespace()
        autocmd FileType go autocmd BufWritePre <buffer> Fmt
        autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
        "au FileType c,cpp setlocal comments-=:// comments-=:/**/  comments+=f://
        "au FileType c,cpp setlocal comments=sO:*/ -,mO:*/ / ,exO:*/,s1:/*
        "autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    " }}}

    " Key (re)Mappings {{{
        let mapleader = ","
        let g:mapleader = ","

        noremap <leader>/ ^i//<esc>
        nmap <leader>w :w!<cr>
        nmap <leader>q :q<cr>
        nmap <leader>wq :wq!<cr>
        nmap <silent> <leader>fe :Sexplore!<cr>
        nmap \o :set paste!<CR>
        nmap \l :setlocal number!<CR>
        "nmap \q :nohlsearch<CR>
        nmap \w :setlocal wrap!<CR>:setlocal wrap?<CR>

        "补全功能
        inoremap <C-]>             <C-X><C-]>
        inoremap <C-F>             <C-X><C-F>
        inoremap <C-D>             <C-X><C-D>
        inoremap <C-L>             <C-X><C-L>
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
        " Yank from the cursor to the end of the line, to be consistent with C and D.
        nnoremap Y y$
        " Visual shifting (does not exit Visual mode)
        vnoremap < <gv
        vnoremap > >gv
        map <Leader>= <C-w>=
        " Map <Leader>ff to display all lines with keyword under cursor
        " and ask which one to jump to
        nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
        " Easier horizontal scrolling
        map zl zL
        map zh zH
        map <leader>h :wincmd h<CR>
        map <leader>j :wincmd j<CR>
        map <leader>k :wincmd k<CR>
        map <leader>l :wincmd l<CR>

        "nnoremap <leader>v <C-w>v
        " Wrapped lines goes down/up to next row, rather than next line in file.
        nnoremap j gj
        nnoremap k gk
        nnoremap gj j
        nnoremap gk k
        nnoremap ; :

        "use sane regexes
        nnoremap / /\v
        vnoremap / /\v

        nnoremap <buffer> <silent> <F5> : YRShow<cr>
        inoremap <buffer> <silent> <F5> <esc>: YRShow<cr>
        "inoremap <F1> <esc>
        "nnoremap <F1> <esc>
        "vnoremap <F1> <esc>
        "nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<CR>''
        nnoremap <leader>l yypVr=
        "nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
        "nnoremap <leader>r yypVr=
        nnoremap <leader>r :RainbowParenthesesLoadBraces<cr>
        "au FocusLost *:wa
        silent! call repeat#set("\<Plug>MyWonderfulMap",v:count)

        nmap tn <C-w>hj<CR>
        nmap tb <C-w>hk<CR>
        nmap <F8> :A<CR>
        " Keep the cursor in place while joining lines
        nnoremap J mzJ`z

        " Split line (sister to [J]oin lines)
        " The normal use of S is covered by ccso don't worry about shadowing it.
        nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w'

        runtime macros/matchit.vim
        "map    <tab> %

        "made D behave
        nnoremap D d$

        " Heresy
        inoremap <c-a> <esc>I
        inoremap <c-e> <esc>A

        "already moves to "last place you exited insert mode"so we'll map gI to
        " something similar: move to last change
        nnoremap gI `.'

        "nnoremap <F9> :s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g<CR>
        "vnoremap <F9> :s/\%V\(\w\)\(\w*\)\%V/\u\1\L\2/g<CR>
        "nnoremap <F8> guw
        "nnoremap <F10> gUw

        "map <silent> <F12> :TagbarToggle<cr> :WMToggle<cr> :wincmd h<CR>

        onoremap in( :<c-u>normal! f(vi(<cr>
        onoremap il( :<c-u>normal! f)vi(<cr>
        onoremap ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
        "Cscope
        "nnoremap <F3> :strftime("%Y_%m_%d-%H:%M"<CR>
        "iab xdate <c-r>=strftime("20%y/%m/%d")<cr>
        "move lines around from vimwiki
        "nnoremap <S-j> :m .+1<CR>==
        "nnoremap <S-k> :m .-2<CR>==
        "inoremap <S-j> <Esc>:m .+1<CR>==gi
        "inoremap <S-k> <Esc>:m .-2<CR>==gi
        "vnoremap <S-j> :m '>+1<CR>gv=gv
        "vnoremap <S-k> :m '<-2<CR>gv=gv

        "set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

        "nnoremap <leader><space> :noh<cr>

        nnoremap <up> <nop>
        nnoremap <left> <nop>
        nnoremap <right> <nop>
        nnoremap <down> <nop>
        inoremap <up> <nop>
        inoremap <left> <nop>
        inoremap <right> <nop>
        inoremap <down> <nop>
        "hidden cmd prompt
        "set cmdheight=2

        " 用空格键来开关折叠
        "set foldenable
        "set foldmethod=indent
        "nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc':'zo')<CR>

        "code complete
        "let g:completekey="<leader><Space>"
        """""""""""""""""""""""""new add end""""""""""""""""""""""""""""""""""""""
        "Fast reloading of the .vimrc
        "map <silent> <leader>ss :source ~/.vimrc<cr>
        "Fast editing of .vimrc
        nnoremap <silent> <leader>ee :e ~/.vimrc<cr>
        nnoremap <silent> <leader>eg :e ~/.vim/.gitmodules<cr>
        "When .vimrc is edited, reload it
        autocmd! bufwritepost .vimrc source ~/.vimrc
        nnoremap <C-e> 3<C-e>
        nnoremap <C-y> 3<C-y>
        nnoremap <C-j> 3j
        nnoremap <C-k> 3k
        nnoremap <leader>cl :silent! %s/^ *//

    " }}}

    " Plugins {{{
    " quickbuf{
    let g:qb_hotkey = "<F1>"
    " }

    "showmarks{
    " Enable ShowMarks
    let showmarks_enable = 0
    " Show which marks
    let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    " Ignore help, quickfix, non-modifiable buffers
    let showmarks_ignore_type = "hqm"
    " Hilight lower & upper marks
    let showmarks_hlline_lower = 1
    let showmarks_hlline_upper = 1
    " For showmarks plugin
    hi ShowMarksHLl ctermbg=Yellow   ctermfg=Black  guibg=#FFDB72    guifg=Black
    hi ShowMarksHLu ctermbg=Magenta  ctermfg=Black  guibg=#FFB3FF    guifg=Black
    "<Leader>mt   - 打开/关闭ShowMarks插件
    "<Leader>mo   - 强制打开ShowMarks插件
    "<Leader>mh   - 清除当前行的标记
    "<Leader>ma   - 清除当前缓冲区中所有的标记
    "<Leader>mm   - 在当前行打一个标记，使用下一个可用的标记名
    "}

    " powerline{
    set guifont=PowerlineSymbols\ for\ Powerline
    set nocompatible
    set t_Co=256
    let g:Powerline_symbols = 'fancy'
    " }

    "ctrlp{
    nnoremap <silent> <Leader>f :CtrlP<cr>
    nnoremap <silent> <Leader>b :CtrlPBuffer<cr>
    nnoremap <silent> <Leader>m :CtrlPMRU<cr>
    "Flush then CtrlP
    nnoremap <silent> <leader>F :ClearCtrlPCache<cr>\|:CtrlP<cr>
    "nnoremap <silent> <leader>T :CtrlPClearAllCaches<cr>\|:CtrlP<cr>
    let g:ctrlp_match_window_bottom = 0
    let g:ctrlp_match_window_reversed = 0
    set wildignore+=/tmp/*,*/patch*/*,*.so,*.swp,*.zip,*.mk,*.img,*.jar,*.dll,*.svn,*.png,*.jpg,*.bmp,*.mk,*.class,*.html,*cscope*,*.text,*.txt,*.doc,*.docx,*~

    "let g:ctrlp_custom_ignore = {
                "\ 'dir': '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$\|tools$\|abi$\|out$',
                "\ 'file': '\.exe$\|\.so$\|\.dat$'
                "\ }
    let g:ctrlp_max_files=0
    let g:ctrlp_working_path_mode = 0
    let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_user_command = "find %s -type f | egrep -v '/\.(git|hg|svn)|solr|tmp|out|data|log|tmp|tools|abi|out' | egrep -v '\.(png|exe|jpg|gif|jar|class|swp|swo|log|gitkep|keepme|so|o)$'"
    let g:ctrlp_clear_cache_on_exit=0
    let g:ctrlp_dotfiles = 0
    let g:ctrlp_switch_buffer = 0
    let g:ctrlp_regexp = 1
    " 此行设置根目录标记为 .crtlp
    "let g:ctrlp_user_command = ['ctrlptags', 'cat %s/ctrlptags']
    "let g:ctrlp_root_markers = ['ctrlptags']
    "let g:ctrlp_root_markers = ['.ctrlp']
    "}
    " xptemplate{
    "<c-\> and <tab>
    " }

    " ZoomWin{

    " }

    "yankring{

    "settings to try to get yank ring to not mess with default vim
    " functionality so much.
    let g:yankring_manage_numbered_reg = 0
    let g:yankring_clipboard_monitor = 0
    let g:yankring_paste_check_default_buffer = 0

    " Don't let yankring use f, t, /. It doesn't record them properly in macros
    " and that's my most common use. Yankring also blocks macros of macros (it
    " prompts for the macro register), but removing @ doesn't fix that :(
    let g:yankring_zap_keys = ''

    " Disable yankring for regular p/P. This preserves vim's normal behavior, but
    " I can still use C-p/C-n to cycle through yankring.
    let g:yankring_paste_n_bkey = ''
    let g:yankring_paste_n_akey = ''
    let g:yankring_paste_v_key = ''

    vnoremap yd "ad
    vnoremap ya "ay
    map pa "ap
    "}

    "imap <C-space> <Plug>snipMateNextOrTrigger
    "smap <C-space> <Plug>snipMateNextOrTrigger

    "pathogen{
    source ~/.vim/bundle/pathogen.vim/autoload/pathogen.vim
    call pathogen#infect()
    call pathogen#incubate()
    "call pathogen#helptags()
    "}

    "window manager{
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
    "}

    "quickfix window{
    nmap cwl :cw<cr>
    nmap ccl :ccl<cr>
    "nnoremap <F2> :buffers<CR>:buffer<Space>
    "nmap <F5> :BufExplorer<cr>
    nmap <F6> :cn<cr>
    nmap <F7> :cp<cr>
    "}

    "lookupfile{
    let g:LookupFile_MinPatLength = 2               "最少输入2个字符才开始查找
    let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
    let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
    let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
    let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
    nnoremap <buffer> <silent> <leader>lk :LookupFile<cr>
    "nmap <unique> <silent> <leader>lk <Plug>LookupFile
    "imap <buffer> <unique> <expr> <silent> <leader>lk (pumvisible()?”\<C-E>”:”").”\<Esc>\<Plug>LookupFile”
    "
    nmap <silent> <leader>ll :LUBufs<cr>
    nmap <silent> <leader>lw :LUWalk<cr>
    "close lookupfile by type esc key twice
    if filereadable("./filenametags")                "设置tag文件的名字
        let g:LookupFile_TagExpr = '"./filenametags"'
    endif
    "}

    "taglist{
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
    "}


    "BufExplorer{
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
    "}

    " OmniComplete {
        "if has("autocmd") && exists("+omnifunc")
            "autocmd Filetype *
                        "\if &omnifunc == "" |
                        "\setlocal omnifunc=syntaxcomplete#Complete |
                        "\endif
        "endif

        "hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        "hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        "hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

        "" Some convenient mappings
        "inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
        "inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
        "inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
        "inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
        "inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        "inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

        "" Automatically open and close the popup menu / preview window
        "au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        "set completeopt=menu,preview,longest
    " }

    " Ctags {
    "set tags=./tags;/,~/.vimtags
    set tags=tags
    " }

    " Cscope {
    set cscopequickfix=s-!,c-,d-,i-,t-,e-
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>:cw<CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>:cw<CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>:cw<CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>:cw<CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>:cw<CR>
    nmap <C-\>f :cs find g <C-R>=expand("<cword>")<CR><CR>:cw<CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cword>")<CR><CR>:cw<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>:cw<CR>
    "add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    " }

    " SnipMate {
    " Setting the author var
    " If forking, please overwrite in your .vimrc.local file
    let g:snips_author = 'Steve Francia <steve.francia@gmail.com>'
    " }

    " NerdTree {
    map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
    "map <leader>e :NERDTreeFind<CR>
    "nmap <leader>nt :NERDTreeFind<CR>

    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
    let g:nerdtree_tabs_open_on_gui_startup=0
    let NERDChristmasTree=1
    let NERDTreeAutoCenter=1
    "let NERDTreeBookmarksFile='~/.vim/NerdBookmarks.txt'
    let NERDTreeMouseMode=2
    let NERDTreeShowBookmarks=1
    let NERDTreeShowFiles=1
    let NERDTreeShowLineNumbers=1
    let NERDTreeWinPos='left'
    let NERDTreeWinSize=31
    "nnoremap <F2> :NERDTreeToggle ./<CR>
    "map <leader>d :execute 'NERDTreeToggle' . getcwd()<CR>
    "silent! nmap <C-p> :NERDTreeToggle<CR>
    silent! map <F3> :NERDTreeFind<CR>
    let g:NERDTreeMapActivateNode="<F3>"
    let g:NERDTreeMapPreview="<F5>"
    let g:netrw_winsize = 40            "open current directory where the present file exist
    autocmd Filetype nerdtree nnoremap <buffer> <leader>b :Bookmark<space>
    " }

    " Tabularize {
    nmap <Leader>a& :Tabularize /&<CR>
    vmap <Leader>a& :Tabularize /&<CR>
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:<CR>
    vmap <Leader>a: :Tabularize /:<CR>
    nmap <Leader>a:: :Tabularize /:\zs<CR>
    vmap <Leader>a:: :Tabularize /:\zs<CR>
    nmap <Leader>a, :Tabularize /,<CR>
    vmap <Leader>a, :Tabularize /,<CR>
    nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    " }

    " Session List {
    set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
    "nmap <leader>sl :SessionList<CR>
    "nmap <leader>ss :SessionSave<CR>
    " }

    " TagBar {
    "nnoremap <silent> <leader>tt :TagbarToggle<CR>
    let tagbar_left=1
    let g:tagbar_width = 40
    let g:tagbar_autofocus = 0
    autocmd VimEnter * nested :call tagbar#autoopen(1)
    nmap <F4> :TagbarToggle<CR>

    " If using go please install the gotags program using the following
    " go install github.com/jstemmer/gotags
    " And make sure gotags is in your path
    let g:tagbar_type_go = {
                \ 'ctagstype' : 'go',
                \ 'kinds'     : [  'p:package', 'i:imports:1', 'c:constants', 'v:variables',
                \ 't:types',  'n:interfaces', 'w:fields', 'e:embedded', 'm:methods',
                \ 'r:constructor', 'f:functions' ],
                \ 'sro' : '.',
                \ 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' },
                \ 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' },
                \ 'ctagsbin'  : 'gotags',
                \ 'ctagsargs' : '-sort -silent'
                \ }
    "}

    " Fugitive {
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
    nnoremap <silent> <leader>gw :Gwrite<CR>:GitGutter<CR>
    nnoremap <silent> <leader>gg :GitGutterToggle<CR>
    "}

    " neocomplcache {
    let g:acp_enableAtStartup = 0
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_smart_case = 1
    let g:neocomplcache_enable_underbar_completion = 1
    let g:neocomplcache_enable_auto_delimiter = 1
    let g:neocomplcache_force_overwrite_completefunc = 1
    let g:neocomplcache_min_syntax_length = 3
    let g:neocomplcache_enable_auto_select = 1

    " SuperTab like snippets behavior.
    imap <silent><expr><TAB> neosnippet#expandable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
                \ "\<C-e>" : "\<TAB>")
    smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

    " Define dictionary.
    let g:neocomplcache_dictionary_filetype_lists = {
                \ 'default' : '',
                \ 'vimshell' : $HOME.'/.vimshell_hist',
                \ 'scheme' : $HOME.'/.gosh_completions'
                \ }

    " Define keyword.
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns._ = '\h\w*'

    " <TAB>: completion.
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

    " <CR>: close popup
    " <s-CR>: close popup and save indent.
    inoremap <buffer> <expr><s-CR> pumvisible() ? neocomplcache#close_popup(): "\<CR>\<CR>"
    inoremap <buffer> <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
    inoremap <buffer> <expr><SPACE> pumvisible() ? neocomplcache#cancel_popup() : "\<SPACE>"

    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <buffer> <expr><BS> neocomplcache#smart_close_popup() "\<C-h>"
    inoremap <buffer> <expr><C-h> neocomplcache#smart_close_popup() "\<C-h>"
    inoremap <buffer> <expr><C-y> neocomplcache#smart_close_popup()
    inoremap <buffer> <expr><C-e>  neocomplcache#cancel_popup()

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

    " Enable heavy omni completion.
    if !exists('g:neocomplcache_omni_patterns')
        let g:neocomplcache_omni_patterns = {}
    endif
    let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

    " Use honza's snippets.
    let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

    " Enable neosnippet snipmate compatibility mode
    let g:neosnippet#enable_snipmate_compatibility = 1

    " For snippet_complete marker.
    if has('conceal')
        set conceallevel=2 concealcursor=i
    endif

    " Disable the neosnippet preview candidate window
    " When enabled, there can be too much visual noise
    " especially when splits are used.
    set completeopt-=preview
    "endif
    " }


    " SuperTab {
    let g:SuperTabRetainCompletionType = 2
    let g:SuperTabDefaultCompletionType = "<C-X><C-N>"
    set completeopt=longest,menu
    nnoremap ,cd :cd %:p:h<CR>
    "}

    ino <c-j> <c-r>=TriggerSnippet()<cr>
    snor <c-j> <esc>i<right><c-r>=TriggerSnippet()<cr>

    " UndoTree {
    nnoremap <Leader>u :UndotreeToggle<CR>
    " If undotree is opened, it is likely one wants to interact with it.
    let g:undotree_SetFocusWhenToggle=1
    " }

    "indent_guides {
    if !exists('g:spf13_no_indent_guides_autocolor')
        "let g:indent_guides_auto_colors = 1
        let g:indent_guides_auto_colors = 0
        autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red ctermbg=3
        autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
    else
        " For some colorschemes, autocolor will not work (eg: 'desert', 'ir_black')
        let g:indent_guides_auto_colors = 0
        autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red ctermbg=3
        autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
        "autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#212121 ctermbg=3
        "autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#404040 ctermbg=4
    endif
    "hi IndentGuidesOdd  ctermbg=black
    "hi IndentGuidesEven ctermbg=darkgrey
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
    let g:indent_guides_enable_on_vim_startup = 1
    " }

    " }}}

    " Functions {{{

    function! UnBundle(arg, ...)
        let bundle = vundle#config#init_bundle(a:arg, a:000)
        call filter(g:bundles, 'v:val["name_spec"] != "' . a:arg . '"')
    endfunction

    com! -nargs=+         UnBundle
                \ call UnBundle(<args>)

    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        " To specify a different directory in which to place the vimbackup,
        " vimviews, vimundo, and vimswap files/directories, add the following to
        " your .vimrc.local file:
        "   let g:spf13_consolidated_directory = <full path to desired directory>
        "   eg: let g:spf13_consolidated_directory = $HOME . '/.vim/'
        if exists('g:spf13_consolidated_directory')
            let common_dir = g:spf13_consolidated_directory . prefix
        else
            let common_dir = parent . '/.' . prefix
        endif

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction

    function! NERDTreeInitAsNeeded()
        redir => bufoutput
        buffers!
        redir END
        let idx = stridx(bufoutput, "NERD_tree")
        if idx > -1
            NERDTreeMirror
            NERDTreeFind
            wincmd l
        endif
    endfunction

    function! StripTrailingWhitespace()
        " To disable the stripping of whitespace, add the following to your
        " .vimrc.local file:
        "   let g:spf13_keep_trailing_whitespace = 1
        if !exists('g:spf13_keep_trailing_whitespace')
            " Preparation: save last search, and cursor position.
            let _s=@/
            let l = line(".")
            let c = col(".")
            " do the business:
            %s/\s\+$//e
            " clean up: restore previous search history, and cursor position
            let @/=_s
            call cursor(l, c)
        endif
    endfunction

    " Remove trailing whitespace when writing a buffer, but not for diff files.
    " From: Vigil <vim5632@rainslide.net>
    function! RemoveTrailingWhitespace()
        if &ft != "diff"
            let b:curcol = col(".")
            let b:curline = line(".")
            silent! %s/\s\+$//
            silent! %s/\(\s*\n\)\+\%$//
            call cursor(b:curline, b:curcol)
        endif
    endfunction

    "括号自动补全
    function! ClosePair(char)
        if getline('.')[col('.') - 1] == a:char
            return "\<Right>"
        else
            return a:char
        endif
    endfunction

    ""nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    "let g:winword = "hello"
    "map ch :call Cppsearch()<cr>
    "function! Cppsearch()
        "let wincursor = line(".")
        "let g:winword=expand("<cword>")
        ""cs find s g:winword<cr>
        "execute "normal! cs find s CamAdapter\r\r"
        ""call setline(wincursor, "")
        ""call append(wincursor+1, g:winword)
    "endfunction

    "map cx :call Cppsearch1()<cr>
    "function! Cppsearch1()
        "let wincursor = line(".")
        "call setline(wincursor, "")
        "call append(wincursor+1, g:winword)
    "endfunction

    "map cadd :call Cppadd()<cr>
    "function! Cppadd()
    "let wincursor = line(".")
    "call setline(wincursor, "")
    "call append(wincursor, "#ifdef VENDOR_EDIT")
    "call append(wincursor+1, "//zhiquan.huang@MMApp.Camera, ".strftime("%Y-%m-%d")." Add for yv12 postview resize")
    "call append(wincursor+2, "#endif /* VENDOR_EDIT */")
    "call append(wincursor+3, "")
    "endfunction

    "添加代码加入vendor_edit注释
    vmap cadd <esc>:call Cppadd(1)<cr>'<<cr>kk$
    imap <leader>cadd <esc>:call Cppadd(0)<cr>jjj$a
    nmap cadd :call Cppadd(0)<cr>jjj$
    function! Cppadd(isVisual)
        if a:isVisual
            let firstLine = line("'<")
            let lastLine = line("'>")
            let wincursor = line("'<")-1
        else
            let wincursor = line(".")
            let firstLine = line(".")
            let lastLine = line(".")
        endif
        "call setline(wincursor, "")
        call append(wincursor, "")
        call append(wincursor+1, "#ifdef VENDOR_EDIT")
        call append(wincursor+2, "//zhiquan.huang@MMApp.Camera, ".strftime("%Y/%m/%d")." add for ")
        call append(lastLine+3, "#endif /* VENDOR_EDIT */")
        call append(lastLine+4, "")
    endfunction

    "删除代码加入vendor_edit注释
    vmap cdel <esc>:call Cppdel(1)<cr>'<<cr>kk$
    "imap <leader>cdel <esc>:call Cppdel(0)<cr>jjj$a
    "nmap cdel :call Cppdel(0)<cr>jjj$
    function! Cppdel(isVisual)
        if a:isVisual
            let firstLine = line("'<")
            let lastLine = line("'>")
            let wincursor = line("'<")-1
        else
            let wincursor = line(".")
            let firstLine = line(".")
            let lastLine = line(".")
        endif
        "call setline(wincursor, "")
        call append(wincursor, "")
        call append(wincursor+1, "#ifndef VENDOR_EDIT")
        call append(wincursor+2, "//zhiquan.huang@MMApp.Camera, ".strftime("%Y/%m/%d")." del for ")
        call append(lastLine+3, "#endif /* VENDOR_EDIT */")
        call append(lastLine+4, "")
    endfunction

    "修改代码加入vendor_edit注释
    vmap cmod <esc>:call Cppmod(1)<cr>'><cr>j
    "imap <leader>cmod <esc>:call Cppmod(0)<cr>jjj$a
    "nmap cmod :call Cppmod(0)<cr>jjj$
    function! Cppmod(isVisual)
        if a:isVisual
            let firstLine = line("'<")
            let lastLine = line("'>")
            let wincursor = line("'<")-1
        else
            let wincursor = line(".")
            let firstLine = line(".")
            let lastLine = line(".")
        endif
        "call setline(wincursor, "")
        call append(wincursor, "")
        call append(wincursor+1, "#ifndef VENDOR_EDIT")
        call append(wincursor+2, "//zhiquan.huang@MMApp.Camera, ".strftime("%Y/%m/%d")." mod for ")
        call append(lastLine+3, "#else /* VENDOR_EDIT */")
        call append(lastLine+4, "")
        call append(lastLine+5, "#endif /* VENDOR_EDIT */")
        call append(lastLine+6, "")
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
    "进行版权声明的设置
    "添加或更新头
    map <F9> :call TitleDet()<cr>'s
    function! AddTitle()
        call append(0,"/*=============================================================================")
        call append(1,"#")
        call append(2,"# Author: dantezhu - dantezhu@vip.qq.com")
        call append(3,"#")
        call append(4,"# QQ : 327775604")
        call append(5,"#")
        call append(6,"# Last modified: ".strftime("%Y-%m-%d %H:%M"))
        call append(7,"#")
        call append(8,"# Filename: ".expand("%:t"))
        call append(9,"#")
        call append(10,"# Description: ")
        call append(11,"#")
        call append(12,"=============================================================================*/")
        echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
    endf
    "更新最近修改时间和文件名
    function! UpdateTitle()
        normal m'
        execute '/# *Last modified:/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'
        normal ''
        normal mk
        execute '/# *Filename:/s@:.*$@\=":\t\t".expand("%:t")@'
        execute "noh"
        normal 'k
        echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
    endfunction
    "判断前10行代码里面，是否有Last modified这个单词，
    "如果没有的话，代表没有添加过作者信息，需要新添加；
    "如果有的话，那么只需要更新即可
    function! TitleDet()
        let n=1
        "默认为添加
        while n < 20
            let line = getline(n)
            if line =~ '^\#\s*\S*Last\smodified:\S*.*$'
                call UpdateTitle()
                return
            endif
            let n = n + 1
        endwhile
        call AddTitle()
    endfunction

     " }}}

        nnoremap <silent> n n:doautocmd TagbarAutoCmds CursorHold<CR>
        nnoremap <silent> N N:doautocmd TagbarAutoCmds CursorHold<CR>
        " Search for selected text, forwards or backwards.
        vnoremap <silent> * :<C-U>
                    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
                    \gvy/<C-R><C-R>=substitute(
                    \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
                    \gV:call setreg('"', old_reg, old_regtype)<CR>

        vnoremap <silent> # :<C-U>
                    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
                    \gvy?<C-R><C-R>=substitute(
                    \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
                    \gV:call setreg('"', old_reg, old_regtype)<CR>
        vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

        hi Search term=standout ctermfg=0 ctermbg=3
        hi link EasyMotionTarget ErrorMsg
        hi link EasyMotionShade  Comment
        let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }

        func! MyCtrlPMappings()
            nnoremap <buffer> <silent> <c-@> :call <sid>DeleteBuffer()<cr>
        endfunc

        func! s:DeleteBuffer()
            exec "bd" fnamemodify(getline('.')[2:], ':p')
            exec "norm \<F5>"
        endfunc
        nnoremap / /\v
        vnoremap / /\v
