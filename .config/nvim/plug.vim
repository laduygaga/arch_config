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
" Plug 'cohama/lexima.vim' " auto close parentheses
if has("nvim")
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " call mkdp#util#install()
  Plug 'neovim/nvim-lspconfig'
  Plug 'github/copilot.vim'
  Plug 'tami5/lspsaga.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'jmerle/competitive-companion'
  Plug 'p00f/cphelper.nvim'
  " Plug 'metakirby5/codi.vim' " interactive scratchpad for hackers. 
  " Plug 'nvim-telescope/telescope.nvim'
  " Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
  Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
  Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
  " mkdir .virtualenvs
  " cd .virtualenvs
  " python -m venv debugpy
  " debugpy/bin/python -m pip install debugpy
  
  " git clone https://github.com/tree-sitter/tree-sitter-python.git
  " cd tree-sitter-python
  " mkdir -p ~/.config/nvim/parser
  " cc -O2 -o ~/.config/nvim/parser/python}.so -I./src src/parser.c src/scanner.cc -shared -Os -lstdc++ -fPIC

  Plug 'mfussenegger/nvim-dap'
  Plug 'mfussenegger/nvim-dap-python' " require debuggy
  Plug 'leoluz/nvim-dap-go' " require delve
  Plug 'theHamsta/nvim-dap-virtual-text'
  Plug 'rcarriga/nvim-dap-ui'
  " Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  " Plug 'sebdah/vim-delve'
endif

" Plug 'puremourning/vimspector'
Plug 'joshdick/onedark.vim'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
" Plug 'lepture/vim-jinja'
Plug 'tpope/vim-surround'
Plug 'echuraev/translate-shell.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ggreer/the_silver_searcher'
Plug 'pamacs/vim-srt-sync'
Plug 'rking/ag.vim'
call plug#end()

