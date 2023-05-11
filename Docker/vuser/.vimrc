let mapleader = ','
set number  			" 显示行号
set incsearch           " 实时开启搜索高亮
set hlsearch			" 搜索结果高亮
set autoindent			" 自动缩进
set smartindent			" 智能缩进
set tabstop=2			" 设置tab制表符号所占宽度为4
set softtabstop=2		" 设置按tab时缩进宽度为4
set shiftwidth=2		" 设置自动缩进宽度为4
set expandtab			" 缩进时将tab制表服转为空格
set smartcase           " 开启智能大小写查找
set encoding=utf-8      " Use UTF-8.
set showcmd             " Display incomplete commands.
set clipboard=unnamedplus " 开启系统剪切板
set cursorline          " 高亮当前行
set ignorecase          " 设置忽略大小写
set smartcase           " 设置智能大小写
set ruler               " 设置显示当前位置
" set autoread
filetype on			" 开启文件类型检测
filetype plugin indent on  " 开启文件类型插件检测
syntax on 			" 开启语法高亮

" 插件管理
call plug#begin('~/.vim/plugged')

" style start
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
" style end

call plug#end()

" 设置主题
syntax on
set t_Co=256
set cursorline
colorscheme onehalfdark
let g:airline_theme='onehalfdark'
" lightline
" let g:lightline = { 'colorscheme': 'onehalfdark' }

" airline
let g:airline#extensions#tabline#enabled = 1                " 设置允许修改默认tab样式
let g:airline#extensions#tabline#formatter = 'jsformatter'  " 设置默认tab栏样式

