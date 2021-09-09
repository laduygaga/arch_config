filetype plugin indent on
filetype on
syntax on

" always show the status bar
set laststatus=2
set statusline+=%F
set title
set titlestring=%F

" enable 256 colors
set t_Co=256
set t_ut=
" windows
set winheight=25
set winwidth=80
set fo+=t

" turn on line numbering
set number
set relativenumber

" sane text files
set fileformat=unix
set encoding=utf-8
set fileencoding=utf-8

" sane editing
" setlocal noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set colorcolumn=80
set viminfo='25,\"50,n~/.config/nvim/.viminfo
set autoread

set mouse=
let g:is_mouse_enabled = 0
function ToggleMouse()
	if g:is_mouse_enabled == 0
		echo "Mouse ON"
		set mouse=a
		let g:is_mouse_enabled = 1
	else
		echo "Mouse OFF"
		set mouse=
		let g:is_mouse_enabled = 0
	endif
endfunction


" colorscheme onedark
let g:is_enable_colorscheme = 0
function ToggleColorscheme()
	if g:is_enable_colorscheme == 0
		echo "colorscheme onedark"
		colorscheme onedark
		let g:is_enable_colorscheme = 1
	else
		echo "colorscheme default"
		colorscheme default
		let g:is_enable_colorscheme = 0
	endif
endfunction


" lightline
" set noshowmode
" let g:lightline = { 'colorscheme': 'onedark' }

" code folding
set foldmethod=indent
set foldlevel=99
" zM close all and set foldlevel to 0
" zR open all and set highest foldlevel
" wrap toggle
" setlocal nowrap
function ToggleWrap()
	if &wrap
		echo "Wrap OFF"
		setlocal nowrap
		set virtualedit=all
	else
		echo "Wrap ON"
		setlocal wrap linebreak nolist
		set virtualedit=
		setlocal display+=lastline
	endif
endfunction


" restore place in file from previous session
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" disable autoindent when pasting text
" source: https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

function! XTermPasteBegin()
	set pastetoggle=<Esc>[201~
	set paste
	return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()


"""" mine
"Mode Settings
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[1 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
"Cursor settings:
"  1 -> blinking block
"  2 -> solid block 
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar

set clipboard=unnamed
set timeoutlen=400
" Magic, Make Ctrl-S-Tab, Ctrl-Tab work on alacritty from https://stackoverflow.com/posts/31959285/revisions
" set <F13>=[27;5;9~
" nnoremap <F13> gt
" set <F14>=[27;6;9~
" nnoremap <F14> gT
"
set scrolloff=999
set cmdheight=2
set smartcase
set ignorecase
set path+=**
set hlsearch incsearch
set nrformats-=octal "fix when <c-a> auto add 07 to 10
" set cursorcolumn
" hi CursorColumn cterm=NONE ctermbg=15
set cursorline
hi CursorLine	cterm=NONE ctermbg=227
hi Visual ctermfg=NONE ctermbg=11
hi MatchParen ctermfg=Black ctermbg=LightCyan
hi CursorLineNr term=none cterm=none ctermfg=202 
hi Search term=none cterm=none ctermfg=Black ctermbg=LightCyan

let g:is_expandtab_enabled = 1
function ToggleExpandTab()
	if g:is_expandtab_enabled == 1
		echo "tab to spaces OFF"
		set noexpandtab
				set tabstop=4
		%retab!
		let g:is_expandtab_enabled = 0
	else
		echo "tab to spaces ON"
		set expandtab
				set tabstop=4
		retab
		let g:is_expandtab_enabled = 1
	endif
endfunction

" close scratch buffer YouCompleteMe
" let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_auto_trigger = 1
" let g:SuperTabDefaultCompletionType = '<C-n>'

let $FZF_DEFAULT_COMMAND = "find -L"



if !exists("my_auto_commands_loaded")
	let my_auto_commands_loaded = 1
	let g:LargeFile = 1024 * 1024 * 10
	augroup LargeFile
		autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
	augroup END
endif


function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  " silent! execute 'resize ' . line('$')
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)

let g:netrw_banner=0
let g:netrw_liststyle=3
" switch between normal file and hiding file: key: a
let g:netrw_list_hide = '^\..*'
let g:netrw_hide = 1

" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
	  Lexplore
	  vertical resize 30
endfunction

" vimgrep
"nnoremap <C-k> :<C-u>vimgrep <C-r><C-w> %<CR>:copen<CR><C-w><C-w>*

" grep from root of project
let g:ag_working_path_mode="r"
runtime ./plug.vim
runtime ./maps.vim
" let g:completion_enable_snippet = 'UltiSnips'
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
command! -bang -nargs=* GRg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)


" let g:vimspector_base_dir=expand( '$HOME/.config/nvim/vimspector-config' )
" let g:vimspector_enable_mappings = 'HUMAN'
" packadd! vimspector
