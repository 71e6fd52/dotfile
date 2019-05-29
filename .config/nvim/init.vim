call plug#begin()
Plug 'Valloric/ListToggle'
"Plug 'neomake/neomake'
"Plug 'dojoteef/neomake-autolint'
Plug 'w0rp/ale'
Plug 'iamcco/markdown-preview.vim', { 'for': 'markdown' } "Markdown 显示
Plug 'Lokaltog/vim-easymotion' "快速移动
Plug 'majutsushi/tagbar', { 'on': 'TagbarOpenAutoClose' }
Plug 'scrooloose/nerdcommenter' "快速注释
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'kshenoy/vim-signature'
Plug 'kovisoft/slimv', { 'for': ['lisp', 'scheme'] }
"Plug 'mzlogin/vim-kramdown-tab', { 'for': 'markdown' } "Kramdown 列表缩进
"Plug 'myusuf3/numbers.vim' "相对行号
Plug 'airblade/vim-gitgutter' "git diff
Plug 'jreybert/vimagit'
Plug 'Yggdroot/indentLine' "indent display
Plug 'elzr/vim-json'
"Plug 'fholgado/minibufexpl.vim' "display buffer
"Plug 'lilydjwg/fcitx.vim'
Plug 'gcmt/wildfire.vim' "快速选择
Plug 'sjl/gundo.vim' "tree undo
Plug 'vim-scripts/DrawIt'
Plug 'junegunn/vim-easy-align'
"Plug 'lyuts/vim-rtags'
Plug 'vim-scripts/VisIncr'
Plug 'mileszs/ack.vim' "act ag
"Plug 'arakashic/chromatica.nvim'
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Plug 'pbrisbin/vim-mkdir'
Plug 'tmhedberg/matchit'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'skwp/vim-rspec'
Plug 'Chiel92/vim-autoformat'
Plug 'Shougo/unite.vim'
Plug 'rust-lang/rust.vim'
""""""""""""""
"  autopair  "
""""""""""""""
" Plug 'jiangmiao/auto-pairs'
Plug 'rstacruz/vim-closer'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
""""""""""""""
"  filetype  "
""""""""""""""
Plug 'LokiChaos/vim-tintin'
Plug 'cespare/vim-toml'
Plug 'kchmck/vim-coffee-script'
Plug 'rhysd/vim-crystal'
Plug 'ron-rs/ron.vim'
"""""""""""""
"  airline  "
"""""""""""""
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
""""""""""""""
"  snippets  "
""""""""""""""
Plug 'SirVer/ultisnips'
Plug 'DATechnologyStudio/vim-snippets'
"""""""""""
"  color  "
"""""""""""
"Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
"""""""""""""
"  haskell  "
"""""""""""""
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'alx741/vim-hindent', { 'for': 'haskell' }
Plug 'alx741/vim-stylishask', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'parsonsmatt/intero-neovim', { 'for': 'haskell' }
""""""""""""""""
"  ECMAScript  "
""""""""""""""""
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'carlitux/deoplete-ternjs'
""""""""""""""
"  complate  "
""""""""""""""
" main
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" plugins
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/context_filetype.vim'
" sources
"Plug 'Shougo/deoplete-rct'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/vimshell.vim'
Plug 'fishbullet/deoplete-ruby'
Plug 'fszymanski/deoplete-emoji'
Plug 'zchee/deoplete-zsh'
Plug 'zchee/deoplete-clang'

call plug#end()
let mapleader=","
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                style                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 自动缩进
set cindent
" Tab 宽度
set tabstop=4 "ts
set softtabstop=4 "sts
" 缩进空格数
set shiftwidth=2 "sw
" 用空格代替制表符
set expandtab "et
" tab 输入 sw 而不是 ts 个空格
set smarttab "sta
" 使回格键（backspace）正常处理indent, eol, start等
"set backspace=2
"set list listchars=tab:>-
set list
set listchars=tab:┊\ ,trail:◇
let g:indentLine_setColors = 0
let g:indentLine_char = '┆'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 80.times { print '"' }

"let &colorcolumn="73,".join(range(80, 999), ",")
let &colorcolumn="80"
au FileType rust let &colorcolumn=""
au FileType python let &colorcolumn="100"
let &textwidth=0
au FileType vim let &textwidth=72
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               display                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"winpos 5 5          " 设定窗口位置
"set lines=40 columns=155    " 设定窗口大小, has bug!
set number " 显示行号
"set go=             " 不要图形按钮
"color asmanian2     " 设置背景主题
"set guifont=Courier_New:h10:cANSI   " 设置字体
"syntax on           " 语法高亮
set ruler           " 显示标尺
set showcmd         " 输入的命令显示出来
set foldenable      " 允许折叠
"set foldcolumn=0
"set foldmethod=indent
"set foldlevel=3
set foldmethod=manual   " 手动折叠
set background=dark "背景使用黑色
" 设置配色方案
let g:rehash256=1
"colorscheme solarized
colorscheme molokai
hi Conceal ctermfg=242 ctermbg=234

" Highlight current line
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn
set magic                   " 设置魔术
"set guioptions-=T           " 隐藏工具栏
"set guioptions-=m           " 隐藏菜单栏
" 总是显示状态行
set laststatus=2    " 启动显示状态行(1),总是显示状态行(2)
"搜索逐字符高亮
set hlsearch
set incsearch
" 在被分割的窗口间显示空白，便于阅读
"set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=2
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3
set noshowmode "关闭 mode 显示，airline
set termguicolors "true color
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 code                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8
set enc=utf-8
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                other                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible  "去掉讨厌的有关vi一致性模式
" 设置当文件被改动时自动载入
set autoread
" quickfix模式
"autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
"代码补全
"set completeopt=preview,menu
"共享剪贴板
"set clipboard+=unnamed
"备份
set nobackup
"自动保存
set autowrite
" 输入错误的提示声音
"set noeb
" 在处理未保存或只读文件的时候，弹出确认
set confirm
" 历史记录数
set history=10000
"行内替换
set gdefault
set langmenu=zh_CN.UTF-8
set helplang=cn
" 侦测文件类型
"filetype on
" 载入文件类型插件
"filetype plugin on
" 为特定文件类型载入相关缩进文件
"filetype indent on
" 保存全局变量
set viminfo+=!
" 带有如下符号的单词不要被换行分割
"set iskeyword+=_,$,@,%,#,-
" 字符间插入的像素行数目
"set linespace=0
" 增强模式中的命令行自动完成操作
set wildmenu
" 允许backspace和光标键跨越行边界
"set whichwrap+=<,>,h,l
" 可以在buffer的任何地方使用鼠标
set mouse=a
set selection=exclusive
set selectmode=mouse,key
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
"set report=0
set exrc "local vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 ale                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>f <Plug>(ale_fix)
nmap <leader>h <Plug>(ale_hover)
let g:ale_linters = {
      \   'crystal': ['ameba'],
      \   'rust': ['rls', 'rustfmt'],
      \   'python': ['autopep8', 'pylint'],
      \ }
let g:ale_fixers = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
      \   'ruby': ['rubocop'],
      \   'rust': ['rustfmt'],
      \   'python': ['autopep8'],
      \ }
let g:ale_completion_enabled = 1
nmap <leader>gt <Plug>(ale_go_to_definition_in_tab)
nmap <C-k> <Plug>(ale_previous_wrap)
nmap <C-j> <Plug>(ale_next_wrap)
let g:ale_c_clangtidy_options = "-std=c99"
let g:ale_cpp_clangtidy_options = "-std=c++17"
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
let g:ale_rust_rls_config = {
      \   'rust': {
      \     'clippy_preference': 'on'
      \   }
      \ }
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               deoplate                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
autocmd FileType * if &ft != "python" | let g:deoplete#enable_at_startup = 1 | endif
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              chromatica                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:chromatica#enable_at_startup = 1
let g:chromatica#responsive_mode=1
"let g:chromatica#highlight_feature_level = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              ultisnips                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger = "<C-x>@s<return>"
let g:UltiSnipsJumpBackwardTrigger = "<C-x>@sb"
let g:UltiSnipsJumpForwardTrigger = "<C-x>@sn"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               markdown                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mkdp_path_to_chrome = "firefox-nightly"
"let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 0
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              easymotion                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyMotion_smartcase = 1
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
map <Leader><leader>. <Plug>(easymotion-repeat)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                tagbar                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <F9> :TagbarOpenAutoClose<CR>
" 启动时自动focus
let g:tagbar_autofocus = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               NERDtree                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <F8> :NERDTreeTabsToggle<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                gundo                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <F7> :GundoToggle<CR>
set undofile
set undodir=~/.cache/nvim/gundo/
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                slimv                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType lisp let g:slimv_swank_cmd = '! systemctl --user start slimv-lisp'
au FileType scheme let g:slimv_swank_cmd = '! systemctl --user start slimv-scheme'
let g:lisp_rainbow=1
let g:paredit_electric_return=0
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               wildfire                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <SPACE> <Plug>(wildfire-fuel)
vmap <C-SPACE> <Plug>(wildfire-water)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 ack                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif
nnoremap <Leader>a :Ack!<Space>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               haskell                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""
"  indent  "
""""""""""""
" Helper function, called below with mappings
function! HaskellFormat(which) abort
  if a:which ==# 'hindent' || a:which ==# 'both'
    :Hindent
  endif
  if a:which ==# 'stylish' || a:which ==# 'both'
    silent! exe 'undojoin'
    silent! exe 'keepjumps %!stylish-haskell'
  endif
endfunction

" Key bindings
augroup haskellStylish
  au!
  " Just hindent
  au FileType haskell nnoremap <leader>hi :call HaskellFormat('hindent')<CR>
  " Just stylish-haskell
  au FileType haskell nnoremap <leader>hs :call HaskellFormat('stylish')<CR>
  " First hindent, then stylish-haskell
  au FileType haskell nnoremap <leader>hf :call HaskellFormat('both')<CR>
augroup END
""""""""""""""
"  neco-ghc  "
""""""""""""""
let g:necoghc_enable_detailed_browse = 1
""""""""""""
"  intero  "
""""""""""""
augroup interoMaps
  au!
  " Maps for intero. Restrict to Haskell buffers so the bindings don't collide.

  " Background process and window management
  au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
  au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>

  " Open intero/GHCi split horizontally
  au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR>
  " Open intero/GHCi split vertically
  au FileType haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
  au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>

  " Reloading (pick one)
  " Automatically reload on save
  au BufWritePost *.hs InteroReload
  " Manually save and reload
  au FileType haskell nnoremap <silent> <leader>wr :w \| :InteroReload<CR>

  " Load individual modules
  au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>

  " Type-related information
  " Heads up! These next two differ from the rest.
  au FileType haskell map <silent> <leader>t <Plug>InteroGenericType
  au FileType haskell map <silent> <leader>T <Plug>InteroType
  au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>

  " Navigation
  au FileType haskell nnoremap <silent> <leader>jd :InteroGoToDef<CR>

  " Managing targets
  " Prompts you to enter targets (no silent):
  au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>
augroup END
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              ECMAScript                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set bin if you have many instalations
"let g:deoplete#sources#ternjs#tern_bin = '/path/to/tern_bin'
"let g:deoplete#sources#ternjs#timeout = 1

" Whether to include the types of the completions in the result data. Default: 0
let g:deoplete#sources#ternjs#types = 1

" Whether to include the distance (in scopes for variables, in prototypes for
" properties) between the completions and the origin position in the result
" data. Default: 0
"let g:deoplete#sources#ternjs#depths = 1

" Whether to include documentation strings (if found) in the result data.
" Default: 0
let g:deoplete#sources#ternjs#docs = 1

" When on, only completions that match the current word at the given point will
" be returned. Turn this off to get all results, so that you can filter on the
" client side. Default: 1
"let g:deoplete#sources#ternjs#filter = 0

" Whether to use a case-insensitive compare between the current word and
" potential completions. Default 0
"let g:deoplete#sources#ternjs#case_insensitive = 1

" When completing a property and no completions are found, Tern will use some
" heuristics to try and return some properties anyway. Set this to 0 to
" turn that off. Default: 1
let g:deoplete#sources#ternjs#guess = 0

" Determines whether the result set will be sorted. Default: 1
"let g:deoplete#sources#ternjs#sort = 0

" When disabled, only the text before the given position is considered part of
" the word. When enabled (the default), the whole variable name that the cursor
" is on will be included. Default: 1
let g:deoplete#sources#ternjs#expand_word_forward = 0

" Whether to ignore the properties of Object.prototype unless they have been
" spelled out by at least two characters. Default: 1
"let g:deoplete#sources#ternjs#omit_object_prototype = 0

" Whether to include JavaScript keywords when completing something that is not
" a property. Default: 0
"let g:deoplete#sources#ternjs#include_keywords = 1

" If completions should be returned when inside a literal. Default: 1
let g:deoplete#sources#ternjs#in_literal = 0
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            NERD Commenter                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
autocmd FileType ruby let g:NERDCompactSexyComs = 0
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              autoformat                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:formatdef_rbeautify = '"ruby-beautify".(&expandtab ? "-s -c".shiftwidth() : "-t")'
let g:formatdef_crystal_crystal='"crystal tool format"'
let g:formatters_crystal = ['crystal_crystal']
augroup AutoFormat
  au!
  au BufWritePre * call AutoFormatType()
augroup END
function! AutoFormatType()
  if index(['ruby', 'rust', 'eruby'], &filetype) != -1
    :Autoformat
  endif
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 misc                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
let g:airline_theme = "powerlineish"
" 高亮显示普通txt文件
au BufRead,BufNewFile *  setfiletype txt
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
autocmd Filetype json let g:indentLine_enabled = 0
" au BufRead,BufNewFile *.ron set filetype=rust
let g:rustfmt_autosave = 1
