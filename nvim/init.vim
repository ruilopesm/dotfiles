" Misc
set nocompatible
set autoread
set spelllang=en
set hidden
set mouse=a
set modelines=0
set nomodeline
set relativenumber
set guifont=Fira\ Code\ 10

" Shell
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=$SHELL
endif

" Enconding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos

" Tabs
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

" Indentation
set autoindent
set copyindent

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Plugins
call plug#begin()
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'kovetskiy/sxhkd-vim'
Plug 'ap/vim-css-color'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='term'
let g:airline#extensions#ale#enabled=1
let g:airline_powerline_fonts = 1

Plug 'marko-cerovac/material.nvim'
let g:material_style='darker'

Plug 'xiyaowong/nvim-transparent'
let g:transparent_enabled=v:true

Plug 'mhinz/vim-startify'

Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

Plug 'ciaranm/securemodelines'
Plug 'dpelle/vim-LanguageTool'

Plug 'scrooloose/nerdtree'

if has('nvim')
  function! UpdateRemotePlugins(...)
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction

  Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
else
  Plug 'gelguy/wilder.nvim'

  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'ryanoasis/vim-devicons'
Plug 'lambdalisue/nerdfont.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}
Plug 'elixir-editors/vim-elixir'

call plug#end()

colorscheme material

set wildmode=list:longest,list:full
call wilder#setup({'modes': [':', '/', '?']})
call wilder#set_option('renderer', wilder#popupmenu_renderer({'highlighter': wilder#basic_highlighter()}))

" Python
let g:python_host_prog='~/.asdf/installs/python/2.7.18/bin/python'
let g:python3_host_prog='~/.asdf/installs/python/3.10.5/bin/python'
