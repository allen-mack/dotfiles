" ██╗███╗   ██╗██╗████████╗██╗   ██╗██╗███╗   ███╗
" ██║████╗  ██║██║╚══██╔══╝██║   ██║██║████╗ ████║
" ██║██╔██╗ ██║██║   ██║   ██║   ██║██║██╔████╔██║
" ██║██║╚██╗██║██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
" ██║██║ ╚████║██║   ██║██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
" ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
"
" Author: allen-mack
" Filename: init.vim
" Github: https://github.com/allen-mack/dotfiles

" FISH {{{

if &shell =~# 'fish$'
    set shell=sh
endif

" }}}

" PLUGINS {{{

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-PLUG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"call plug#begin('~/.config/nvim/plugged')
call plug#begin('~/.local/share/nvim/site/autoload/')
" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'mbbill/undotree'
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
" coc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-reference)

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
" EMMET
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:user_emmet_install_global = 0
"autocmd FileType html,css EmmetInstall
" autocmd BufNewFile,BufRead *.json set ft=javascript

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('rg')
  let g:rg_derive_root='true'
endif

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

" }}}

" COLOR {{{

"colorscheme grb256

" }}}

" COMMANDS {{{

" Markdown - Treat *.md files as markdown instead of Modula-2
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Set syntax highlighting on .tmux files
autocmd BufRead,BufNewFile *.tmux set filetype=sh

" Set up Prettier
autocmd FileType javascript set formatprg=prettier\ --stdin

" pretty print the file.
com! Fjson %!python -m json.tool
com! Fxml %!xmllint --format --recover - 2>/dev/null

" toggle spell check
com! SC :setlocal spell! spelllang=en_us

" Insert corpus header
com! CH :call CorpusHeader()<CR>

" }}}

" REMAPS {{{

" Removes highlight of your last search
noremap <C-n> :nohls<CR>
vnoremap <C-n> :nohls<CR>
inoremap <C-n> :nohls<CR>

" Resize vertical splits
nnoremap <silent> <Leader>0 :vertical resize +2<CR>
nnoremap <silent> <Leader>9 :vertical resize -2<CR>

" Tags
"command! MakeTags !ctags -R .

" edit and source the vimrc file
nnoremap <leader>ev :vsp $MYVIMRC<cr>
nnoremap <leader>sv :source $MyVIMRC <bar> :doautocmd BufRead<cr>

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

" map substitute
map S :%s//g<Left><Left>

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" STAMP from yank register
" nnoremap <Leader>p "0p

" Delete selection to null register and paste into its place
" possibly the greatest remap ever
vnoremap <Leader>p "_dP

" Toggle RELATIVE NUMBERS
" nnoremap <Leader>r :set rnu!<cr>
nnoremap <Leader>r :set number! relativenumber!<cr>

" Display Undotree
nnoremap <Leader>u :UndotreeShow<CR>

" STAMP from yank register
nnoremap <Leader>p "0p

" easier way to escape from insert mode
inoremap jk <esc>

" }}}

" SETS {{{

" Enable syntax highlighting
filetype off
filetype plugin indent on
syntax on

set autoindent " align the new line indent with the previous line
" real programmers don't use TABs but spaces
set expandtab " insert spaces when hitting TABs
set incsearch
set nobackup
set noerrorbells
set noswapfile " prevent the creation of swp files
set path+=** " Finding Files
set printoptions=paper:letter,duplex:long " Print Options
set shiftround " round indent to multiple of 'shiftwidth'
set shiftwidth=2 " operation >> indents 2 cols; << unindents 4 cols
set smartindent
set splitbelow              " Splits window BELOW current window
set splitright              " Open new split on the right
set softtabstop=2 " insert/delete 2 spaces when hitting a TAB/BACKSPC
set tabstop=2 " a hard TAB displays as 2 cols
set undodir=~/.config/nvim/undodir
set undofile

" Make searching case insensitive.
" set ignorecase

" let g:netrw_browse_split=2
" let g:netrw_winsize=25
let g:netrw_banner=0

" }}}

" FUNCTIONS {{{

function CorpusHeader()
  let d = strftime('%FT%T%z')
  let cmd =  "normal! gg I---\ntitle: \ntags: \ncreated: " . d . "\n---\n\n\egg j A"
  execute cmd
endfunction

function Vfit()
    let l:maxColumns = max(map(range(1, line('$')), "col([v:val, '$'])")) - 1
    silent! execute 'vertical resize ' . l:maxColumns
endfunction

" }}}

" Modelines will only affect the current file.
" vim:foldmethod=marker:foldlevel=0
