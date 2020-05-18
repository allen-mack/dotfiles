if &shell =~# 'fish$'
    set shell=sh
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-PLUG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"call plug#begin('~/.config/nvim/plugged')
call plug#begin('~/.local/share/nvim/site/autoload/')
" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim'
Plug 'quanganhdo/grb256'
"Plug 'SirVer/ultisnips'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'wincent/command-t'
Plug 'wincent/terminus'

" GO Related plugins
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go'
Plug 'stamblerre/gocode'

" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ultisnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nnoremap <Leader>u g:UltiSnipsListSnippets<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linters = {
  \ 	'go': ['gopls'],
  \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-GO
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1
let g:go_fmt_command = "goimports"
let g:go_def_mode = 'gopls'
let g:go_info_mmode = 'gopls'

" Launch gopls when Go files are in use
let g:LanguageClient_serverCommands = { 'go': ['gopls'] }
" Run gofmt on save
" autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()


" AIRLINE
"set laststatus=2   " Make sure that the status bar is always visible
"set t_Co=256       " Set the color scheme

" COLOR
"colorscheme grb256

" Finding Files
set path+=**

" Markdown - Treat *.md files as markdown instead of Modula-2
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Set up Prettier
autocmd FileType javascript set formatprg=prettier\ --stdin

" Print Options
set printoptions=paper:letter,duplex:long

" Make searching case insensitive.
" set ignorecase

" Removes highlight of your last search
noremap <C-n> :nohls<CR>
vnoremap <C-n> :nohls<CR>
inoremap <C-n> :nohls<CR>

" Resize vertical splits
noremap } <C-w>>
noremap { <C-w><

" Tags
"command! MakeTags !ctags -R .

" make backspace behave like normal again
"set bs=2

" edit and source the vimrc file
"nnoremap <leader>ev :vsplit $MYVIMRC<cr>
"nnoremap <leader>sv :source $MyVIMRC<cr>

" easier moving between tabs
map <Leader>[ <esc>:tabprevious<CR>
map <Leader>] <esc>:tabnext<CR>

" bind Ctrl+<movement> keys to move around the windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" map vsplit carousel keys
map <F12> <c-w>l<c-w><bar>
map <F11> <c-w>h<c-w><bar>

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" Toggle RELATIVE NUMBERS
nnoremap <Leader>r :set rnu!<cr>

" STAMP from yank register
nnoremap <Leader>p "0p

" easier way to escape from insert mode
inoremap jk <esc>

" pretty print the file.
com! Fjson %!python -m json.tool
com! Fxml %!xmllint --format --recover - 2>/dev/null
" open splits in a more intuitive way
set splitbelow              " Splits window BELOW current window
set splitright              " Open new split on the right

" map vim-spec commands
"map <Leader>t :call RunCurrentSpecFile()<CR>
"map <Leader>s :call RunNearestSpec()<CR>
"map <Leader>l :call RunLastSpec()<CR>
"map <Leader>a :call RunAllSpecs()<CR>

" Enable syntax highlighting
filetype off
filetype plugin indent on
syntax on

" real programmers don't use TABs but spaces
set shiftwidth=2 " operation >> indents 2 cols; << unindents 4 cols
set tabstop=2 " a hard TAB displays as 2 cols
set expandtab " insert spaces when hitting TABs
set softtabstop=2 " insert/delete 2 spaces when hitting a TAB/BACKSPC
set shiftround " round indent to multiple of 'shiftwidth'
set autoindent " align the new line indent with the previous line

"let g:user_emmet_install_global = 0
"autocmd FileType html,css EmmetInstall
" autocmd BufNewFile,BufRead *.json set ft=javascript

function Vfit()
    let l:maxColumns = max(map(range(1, line('$')), "col([v:val, '$'])")) - 1
    silent! execute 'vertical resize ' . l:maxColumns
endfunction
