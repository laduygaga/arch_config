if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'voldikss/vim-floaterm'
Plug 'rhysd/git-messenger.vim'

" Plug 'cohama/lexima.vim'

if has("nvim")
  " Plug 'hoob3rt/lualine.nvim'
  " Plug 'kristijanhusak/defx-git'
  " Plug 'kristijanhusak/defx-icons'
  " Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  Plug 'neovim/nvim-lspconfig'
  Plug 'github/copilot.vim'
  " Plug 'glepnir/lspsaga.nvim'
  Plug 'tami5/lspsaga.nvim'
  " Plug 'folke/lsp-colors.nvim'
  Plug 'nvim-lua/completion-nvim'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  " Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'jmerle/competitive-companion'
  Plug 'p00f/cphelper.nvim'
  " Plug 'metakirby5/codi.vim'
  " Plug 'nvim-telescope/telescope.nvim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

" Plug 'groenewege/vim-less', { 'for': 'less' }
" Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
"
"
" Plug 'puremourning/vimspector'
Plug 'joshdick/onedark.vim'
" Plug 'ap/vim-buftabline'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'lepture/vim-jinja'
Plug 'tpope/vim-surround'
Plug 'echuraev/translate-shell.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ggreer/the_silver_searcher'
Plug 'pamacs/vim-srt-sync'
Plug 'rking/ag.vim'
" Plug 'SirVer/ultisnips'


call plug#end()

