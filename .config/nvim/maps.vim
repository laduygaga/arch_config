" Description: Keymaps
" nnoremap <space> za
nnoremap ' `

map <leader><leader>r :Run<CR>
map <leader><leader>b :Break<CR>
map <leader><leader>b :Clear<CR>
map <leader><leader>s :Over<CR>
map <leader><leader>c :Continue<CR>
map <leader><leader>p :Stop<CR>
map <leader><leader>f :Finish<CR>
vnoremap Y "+y
inoremap jk <esc>
nnoremap <silent> <leader>t :tabnew<CR>
nnoremap <silent> <leader>d :tabclose<CR>
nnoremap <silent> <leader>D :qa!<CR>
nnoremap <silent> <C-Tab> gt
nnoremap <silent> <S-Tab> gT
vnoremap <silent> <leader>,, :Trans :vi -b<CR> 
nnoremap <leader>g :Ag <C-r>=expand('<cword>')<CR><CR>
nnoremap <leader>s :AgFromSearch<CR>
map <silent> <leader>e :call ToggleVExplorer()<CR>
noremap <silent> <leader>m :call ToggleMouse()<CR>
noremap <silent> <leader>w :call ToggleWrap()<CR>
nnoremap <leader>T :TagbarToggle<CR>
map <F2> :call ToggleExpandTab()<CR>
map <F4> :call ToggleColorscheme()<CR>


augroup vim_autocmd
	" Prevent Vim from clearing the clipboard on exit
	autocmd VimLeave * call system("xsel -ib", getreg('+'))
	" fix always tabs to spaces when start python file
	" fuck /usr/share/vim/vim74/ftplugin/python.vim
	autocmd FileType python setlocal ts=4 sts=4 sw=4 noexpandtab
	autocmd Filetype python inoremap <silent>  <buffer> <leader>2 <Esc>:%w !python3<CR>
	autocmd Filetype python nnoremap <silent> <buffer> <leader>2 :%w !python3<CR>
	autocmd Filetype python nnoremap <silent> <buffer> <F8> :w<CR>:!clear;python3 %<CR>
	autocmd Filetype python vnoremap <silent> <buffer> <leader>2 !python3<CR>
	autocmd Filetype python inoremap <silent> <buffer> <F5> <Esc>:%w !sudo python3<CR>
	autocmd Filetype python nnoremap <silent> <buffer> <F5> :%w !sudo python3<CR>
	autocmd Filetype php inoremap <silent> <buffer> <leader>2 <Esc>:%w !php<CR>
	autocmd Filetype php nnoremap <silent> <buffer> <leader>2 :%w !php<CR>
	autocmd Filetype php vnoremap <silent> <buffer> <leader>2 !php<CR>
	autocmd Filetype php inoremap <silent> <buffer> <F5> <Esc>:%w !sudo php<CR>
	autocmd Filetype php nnoremap <silent> <buffer> <F5> :%w !sudo php<CR>
	autocmd Filetype sh inoremap <silent> <buffer> <leader>2 <Esc>:%w !bash<CR>
	autocmd Filetype sh nnoremap <silent> <buffer> <leader>2 :%w !bash<CR>
	autocmd Filetype sh vnoremap <silent> <buffer> <leader>2 !bash<CR>
	autocmd Filetype sh nnoremap <silent> <buffer> <F8> :w<CR>:!clear; bash %<CR>
	autocmd Filetype javascript inoremap <silent> <buffer> <leader>2 <Esc>:%w !node<CR>
	autocmd Filetype javascript nnoremap <silent> <buffer> <leader>2 :%w !node<CR>
	autocmd Filetype javascript vnoremap <silent> <buffer> <leader>2 !node<CR>
	autocmd Filetype perl inoremap <silent> <buffer> <leader>2 <Esc>:%w !perl<CR>
	autocmd Filetype perl nnoremap <silent> <buffer> <leader>2 :%w !perl<CR>
	autocmd Filetype perl vnoremap <silent> <buffer> <leader>2 !perl<CR>
	autocmd Filetype perl nnoremap <silent> <buffer> <F8> :w<CR>:!perl %<CR>
	autocmd Filetype c nnoremap  <leader>2 :w<CR>:!clear;gcc -o %:r %:p<CR>:!./%:r<CR>
	autocmd Filetype c inoremap  <leader>2 <Esc>:w<CR>:!clear;gcc -o %:r %:p<CR>:!./%:r<CR>
	autocmd Filetype cpp nnoremap  <leader>2 :w<CR>:!clear;g++ -o %:r %:p<CR>:!./%:r<CR>
	autocmd Filetype cpp inoremap  <leader>2 <Esc>:w<CR>:!clear;g++ -o %:r %:p<CR>:!./%:r<CR>
	autocmd Filetype rust nnoremap	<leader>2 :w<CR>:!clear; rustc % <CR>:!./%:r<CR>
	autocmd Filetype rust inoremap	<leader>2 <Esc>:w<CR>:!clear; rustc % <CR>:!./%:r<CR>
	autocmd Filetype go inoremap <silent>  <buffer> <leader>2 <Esc>:w<CR>:%w !go run %<CR>
	autocmd Filetype go nnoremap <silent> <buffer> <leader>2 :w<CR>:%w !go run %<CR>
	autocmd Filetype go inoremap <silent>  <buffer> <F9> <Esc>:w<CR>:!go build %; ./%:r<CR>
	autocmd Filetype go nnoremap <silent>  <buffer> <F9> :w<CR>:!go build %; ./%:r<CR>

