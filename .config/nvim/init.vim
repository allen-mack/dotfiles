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
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'jremmen/vim-ripgrep'
Plug 'mbbill/undotree'
Plug 'nvim-lua/completion-nvim'
" Plug 'nvim-lua/diagnostic-nvim'
Plug 'quanganhdo/grb256'
"Plug 'SirVer/ultisnips'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'wincent/terminus'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" GO Related plugins
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go'
Plug 'stamblerre/gocode'

" Initialize plugin system
call plug#end()

" Plugin Configuration
source ~/.config/nvim/plug-config/lsp-config.vim
luafile ~/.config/nvim/lua/plugins/compe-config.lua
luafile ~/.config/nvim/lua/lsp/bash-lsp.lua
luafile ~/.config/nvim/lua/lsp/lua-lsp.lua

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nmap <leader>gd <Plug>(coc-definition)
" nmap <leader>gr <Plug>(coc-reference)

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

" LSP {{{

" Completion
set cot=menuone,noinsert,noselect shm+=c

let g:diagnostic_virtual_text_prefix = ''
let g:diagnostic_enable_virtual_text = 1
let g:completion_confirm_key = "\<C-y>"
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

command! Format execute 'lua vim.lsp.buf.formatting()'

:lua << EOF
  local on_attach = function (_, bufner)
    require('diagnostic').on_attach()
    require('completion').on_attach()
  end
EOF

" local nvim_lsp = require('nvim-lspconfig')
"   local servers = {'gopls', 'bashls',}
"   for _, lip in ipairs(servers) do
"     nvim_lsp[lsp].setup {
"       on_attach = on_attach,
"     }
"   end

lua require'lspconfig'.bashls.setup{}
lua require'lspconfig'.cssls.setup{}
" lua require('diagnostic').on_attach()
lua require('completion').on_attach()

" }}}

" COLOR {{{

" colorscheme grb256

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

" Remove trailing spacces
com! Rts %s/\s\+$//e

" toggle spell check
com! SC :setlocal spell! spelllang=en_us

" Insert corpus header
com! CH :call CorpusHeader()<CR>

" }}}

" REMAPS {{{

" Telescope
lua require('telescope').setup({defaults = {file_sorter = require('telescope.sorters').get_fzy_sorter}})

nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.imput("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>pw :lua require('telescope:builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope:builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope:builtin').help_tags()<CR>

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

" Terminal - Get Fish terminals
nnoremap <leader>st :split term://fish<cr>
nnoremap <leader>vt :vsplit term://fish<cr>

" }}}

" SETS {{{

" Enable syntax highlighting
filetype off
filetype plugin indent on
syntax on

set incsearch
set nohlsearch
set noerrorbells
set path+=** " Finding Files
set printoptions=paper:letter,duplex:long " Print Options
set shiftround " round indent to multiple of 'shiftwidth'
set splitbelow              " Splits window BELOW current window
set splitright              " Open new split on the right
" set termguicolors

" history
set noswapfile " prevent the creation of swp files
set nobackup
set undodir=~/.config/nvim/undodir
set undofile

" real programmers don't use TABs but spaces
set tabstop=2 " a hard TAB displays as 2 cols
set softtabstop=2 " insert/delete 2 spaces when hitting a TAB/BACKSPC
set shiftwidth=2 " operation >> indents 2 cols; << unindents 4 cols
set expandtab " insert spaces when hitting TABs
set smartindent
set autoindent " align the new line indent with the previous line

" Make searching case insensitive.
" set ignorecase

" let g:netrw_browse_split=2
" let g:netrw_winsize=25
let g:netrw_banner=0

" }}}

" FUNCTIONS {{{

function CorpusHeader()
  let d = strftime('%FT%T%z')
  let cmd =  "normal! ggI---\ntitle:\ \ntags:\ \ncreated:\ " . d . "\n---\n\n\eggjA"
  execute cmd
endfunction

function Vfit()
    let l:maxColumns = max(map(range(1, line('$')), "col([v:val, '$'])")) - 1
    silent! execute 'vertical resize ' . l:maxColumns
endfunction

" }}}

" Modelines will only affect the current file.
" vim:foldmethod=marker:foldlevel=0
" normal! gg I---\ntitle:\ \ntags:\ \ncreated:\  . d . \n---\n\n\egg j A"
