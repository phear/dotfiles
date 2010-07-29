scriptencoding utf-8
set termencoding=utf-8

if exists('&t_SI')
  let &t_SI = "\<Esc>]12;lightgoldenrod\x7"
  let &t_EI = "\<Esc>]12;grey80\x7"
endif

set nocompatible
set viminfo='1000,f1,:1000,/1000
set history=500
set backspace=indent,eol,start
set textwidth=75
set backup
set showcmd
set showmatch
set hlsearch
set incsearch

if has("autocmd")
  autocmd BufEnter *
	\ if &filetype == "cpp" |
        \     set noignorecase noinfercase |
        \ else |
        \     set ignorecase infercase |
        \ endif
else
  set ignorecase
  set infercase
endif

set showfulltag
set lazyredraw

set noerrorbells
set visualbell t_vb=

if has("autocmd")
  autocmd GUIEnter * set visualbell t_vb=
endif

set scrolloff=3
set sidescrolloff=2

set whichwrap+=<,>,[,]

set wildmenu
set wildignore+=*.o,*~,.lo
set suffixes+=.in,.a,.1
set hidden
set winminheight=1

syntax on

set virtualedit=block,onemore

:colorscheme darkblue

set shiftwidth=2
set autoindent
set smartindent
inoremap # X<BS>#

if has("folding")
    set foldenable
    set foldmethod=manual
    set foldlevelstart=99
endif

set popt+=syntax:y

if has("eval")
    filetype on
    filetype plugin on
    filetype indent on
endif

" Nice statusbar
set laststatus=2
set statusline=
set statusline+=%2*%-3.3n%0*\                " buffer number
set statusline+=%f\                          " file name

set statusline+=%h%1*%m%r%w%0*               " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&encoding},                " encoding
set statusline+=%{&fileformat}]              " file format
if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim"))
    set statusline+=\ %{VimBuddy()}          " vim buddy
endif
set statusline+=%=                           " right align
set statusline+=%2*0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

" If possible and in gvim, use cursor row highlighting
if has("gui_running") && v:version >= 700
    set cursorline
end

" Include $HOME in cdpath
if has("file_in_path")
    let &cdpath=','.expand("$HOME").','.expand("$HOME").'~/'
endif

" Better include path handling
set path+=src/
let &inc.=' ["<]'

set dictionary=/usr/share/dict/words
