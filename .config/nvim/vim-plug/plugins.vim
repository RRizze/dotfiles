call plug#begin("~/.config/nvim/autoload/plugged")

  Plug 'cohama/lexima.vim'
  Plug 'mattn/emmet-vim'
  Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-unimpaired'

  if has("nvim")
    Plug 'neovim/nvim-lspconfig'
    Plug 'glepnir/lspsaga.nvim'
    "Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    "Plug 'nvim-lua/popup.nvim'
    "Plug 'nvim-lua/plenary.nvim'
    "Plug 'nvim-telescope/telescope.nvim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
  endif

  Plug 'ajh17/spacegray.vim'
  Plug 'gosukiwi/vim-atom-dark'
  Plug 'nanotech/jellybeans.vim'

call plug#end()
