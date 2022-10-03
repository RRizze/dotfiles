source $HOME/.config/nvim/vim-plug/plugins.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
""BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
"vi-compatible or more useful way.
set nocompatible
set background=dark
set t_Co=256
"colorscheme spacegray
let g:Hexokinase_highlighters = ['virtual']

"true colors
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

let g:jellybeans_overrides = {
      \ "background": { "guibg": "121212" },
      \  "StatusLineNC": { "guibg": "121212", "ctermbg": "Black" },
      \  "VertSplit": { "guibg": "121212", "ctermbg": "Black" },
      \  "WinSeparator": { "guibg": "1d1d1d", "ctermbg": "Black", "guifg": "121212" },
      \  "SignColumn": { "guibg": "121212", "ctermbg": "Black" },
      \  "FoldColumn": { "guibg": "121212", "ctermbg": "Black" },
      \  "ColorColumn": { "guibg": "121212", "ctermbg": "Black" }
\}
colorscheme jellybeans

let mapleader=","

set number
set numberwidth=7
nmap - dd
imap <c-d> <esc>ddi
" set mark m on z, gU - make Nmove text Uppercase,
nmap <c-u> mzgUiw`z
imap <F8> _<esc>mzwbgUiw`zi<Del>

"Search Options
set hlsearch
set hidden
set incsearch
set hlsearch
"make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
"brackets
set showmatch

"Indentation Options
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

"Increase the undo limit.
set history=10000
set laststatus=2
set cursorline
"set showtabline=2
set switchbuf=useopen
set shell=bash
"Don't make backups at all
set nobackup
set nowritebackup
set directory=/tmp
set backupdir=~/.vim/backups
"set director=$HOME1/.vim/swap//
"keep more context when scrolling off the end of a buffer
set scrolloff=4
set wildmode=full
"set wildmode=longest,list
set wildmenu
set showcmd 

set title
syntax on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

let g:sh_noisk=1

" If a file is changed outside of vim, automatically reload it without
" asking
set autoread

" Use the old vim regex engine (version 1, as opposed to version 2, which
" was introduced in Vim 7.3.969). The Ruby syntax highlighting is significantly
" slower with the new regex engine.
set re=1

" Always show the sign column
set signcolumn=yes

" Diffs are shown side-by-side not above/below
set diffopt=vertical

" Write swap files to disk and trigger CursorHold event faster (default is
" after 4000 ms of inactivity)
" set updatetime=200
" Completion options.
"   menu: use a popup menu
"   preview: show more info in menu
set completeopt=menu,preview

" "let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*
" "let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'


" FILE BROWSING:
" Tweaks for netrw
let g:netrw_banner=0 " disable annoying banner
"let g:netrw_browse_split=4 " open in prior window
let g:netrw_liststyle=3 " tree view

" Misc key maps
"inoremap <c-c> <esc>
nnoremap <leader><space> :nohlsearch<cr>
noremap <c-l> <c-w><c-l>
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
inoremap <s-tab> <c-n>

" Mapping for Lspsaga
nnoremap <silent> <C-j> <Cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent>K <Cmd>Lspsaga hover_doc<CR>
inoremap <silent> <C-k> <Cmd>Lspsaga signature_help<CR>
nnoremap <silent> gh <Cmd>Lspsaga lsp_finder<CR>

nnoremap <silent> ;f :Files<CR>
 
" show current branch git
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#VisualNOS#
set statusline+=%{StatuslineGit()}
set statusline+=%#WildMenu#
set statusline+=\ %f
"set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

autocmd FileType lua set sw=4 sts=4 et
" """"""""""""""""""""""""""""""""""""""""""""""""""
" " VIM-RUBY CONFIGURATION
" """"""""""""""""""""""""""""""""""""""""""""""""""
" Do this:
"   first
"     .second do |x|
"       something
"     end
" Not this:
"   first
"     .second do |x|
"     something
"   end
:let g:ruby_indent_block_style = 'do'
" Do this:
"     x = if condition
"       something
"     end
" Not this:
"     x = if condition
"           something
"         end
:let g:ruby_indent_assignment_style = 'variable'

" """"""""""""""""""""""""""""""""""""""""""""""""""
" " EMMET CONFIGURATION
" """"""""""""""""""""""""""""""""""""""""""""""""""
let g:user_emmet_leader_key=','
let g:user_emmet_settings = {
\  'variables': {'lang': 'en'},
\  'html': {
\    'default_attributes': {
\      'option': {'value': v:null},
\      'textarea': {'id': v:null, 'name': v:null, 'cols': 10, 'rows': 10},
\    },
\    'snippets': {
\      'html:5': "<!DOCTYPE html>\n"
\              ."<html lang=\"${lang}\">\n"
\              ."<head>\n"
\              ."\t<title></title>\n"
\              ."\t<meta charset=\"${charset}\">\n"
\              ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
\              ."\t<meta name=\"description\" content=\"\">\n"
\              ."\t<meta property=\"og:title\" content=\"\">\n"
\              ."\t<meta property=\"og:type\" content=\"website\">\n"
\              ."\t<meta property=\"og:url\" content=\"\">\n"
\              ."\t<meta property=\"og:image\" content=\"\">\n"
\              ."</head>\n"
\              ."<body>\n\t${child}|\n</body>\n"
\              ."</html>",
\    },
\  },
\}

"
" """"""""""""""""""""""""""""""""""""""""""""""""""
" " Command-t remap
" """"""""""""""""""""""""""""""""""""""""""""""""""
" if &term =~ "xterm" || &term =~ "screen"
"   let g:CommandTCancelMap = ['<ESC>', '<C-c>']
"   endif


