let mapleader = ' '
let maplocalleader = ','

call plug#begin()

Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-endwise'
Plug 'Raimondi/delimitMate'
Plug 'Shougo/vimproc.vim', {'do': 'make -f  make_unix.mak'}
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'neomake/neomake'
Plug 'luochen1990/rainbow'

" Haskell
Plug 'pbrisbin/vim-syntax-shakespeare'
Plug 'parsonsmatt/vim2hs'
Plug '~/Projects/intero-neovim'
" Plug 'parsonsmatt/intero-neovim'

" PureScript
Plug 'purescript-contrib/purescript-vim'
Plug 'FrigoEU/psc-ide-vim'

" Rust
Plug 'rust-lang/rust.vim'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'racer-rust/vim-racer'

" Nix
Plug 'LnL7/vim-nix'

" Colorschemes
Plug 'iCyMind/NeoSolarized'
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'
Plug 'tyrannicaltoucan/vim-deep-space'
call plug#end()

execute "set t_8f=\e[38;2;%lu;%lu;%lum"
execute "set t_8b=\e[48;2;%lu;%lu;%lum"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editor Configuration:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

" Why would terminals want line numbers???
au TermOpen * setlocal nonumber norelativenumber

filetype plugin indent on
syntax on

set background=dark
set termguicolors
let g:deepspace_italics=1
colorscheme NeoSolarized
highlight Conceal ctermbg=NONE guibg=NONE

" Clear highlighting
nnoremap <silent> <leader><leader> :noh<CR><C-l>

" Noop the arrow keys in normal mode
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
noremap <PageUp> <nop>
noremap <PageDown> <nop>

" Better search
set incsearch
set hlsearch
set smartcase
set ignorecase

" Filename even with one window:
set laststatus=2

" fat shift fingers
command! W w
command! Q q

nnoremap <Leader>w :w<CR>
nnoremap <Leader>wq :wq<CR>

" Line numbers
set number
set relativenumber
set numberwidth=2
highlight LineNr term=bold cterm=none ctermfg=DarkGrey ctermbg=NONE
highlight CursorLineNr term=bold cterm=none ctermfg=DarkGreen ctermbg=NONE

" Default indentation:
set autoindent
set smartindent
set softtabstop=4
set shiftwidth=4
set expandtab

" highlight the current line in current window; may slow down redrawing
" for long lines or large files
set cursorline
au InsertEnter * set nocursorline
au InsertLeave * set cursorline

" highlight the current column in current window; may slow down redrawing
" for long lines or large files
set cursorcolumn

set scrolloff=5

" Disable folding
set nofoldenable

set ruler

" Load .vim.custom scripts if present.
if filereadable(".vim.custom")
    so .vim.custom
endif

set mouse=a
" Alt-{hjkl} for navigating panes
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Special character inserts
imap <buffer> \forall ∀
imap <buffer> \to →
imap <buffer> \lambda λ
imap <buffer> \Sigma Σ
imap <buffer> \exists ∃
imap <buffer> \equiv ≡

" Show incremental regex replacement
set inccommand=nosplit

" Edit and reload vim configuration
nnoremap <Leader>fed :e ~/.nvim/init.vim<CR>
nnoremap <Leader>fer :so ~/.nvim/init.vim<CR>

nnoremap <A-t> :terminal<CR>

" Pane/split management
nnoremap <Leader>v :vsplit<cr>
nnoremap <Leader>s :split<cr>
nnoremap <Leader>e :FZF<cr>

" when writing to a file in a non-existing directory, create the directory and
" all parents
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Configuration:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" rainbow
let g:rainbow_active=1

" delimitMate:
let delimitMate_expand_cr = 2
let delimitMate_matchpairs = "(:),{:}"
let delimitMate_expand_space = 1

" deoplete
let g:deoplete#enable_at_startup = 1

" Markdown
let g:markdown_fenced_languages = ['java', 'haskell', 'javascript', 'ruby', 'c', 'cpp', 'php']

" Neomake
autocmd BufWritePost * silent Neomake
let g:neomake_open_list = 2

" Tabularize
vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

" deoplete-rust
let g:deoplete#sources#rust#racer_binary='/home/matt/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/home/matt/Projects/rust/src'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Language Configuration:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Haskell
nnoremap <leader>hs :%!stylish-haskell<cr>
let g:haskellmode_completion_ghc = 0

" do tags
nnoremap <silent> <leader>hmt :! (cd `git rev-parse --show-toplevel`; codex update)<CR> 
" :set tags=<C-R>=system("git rev-parse --show-toplevel")<CR><BS>/codex.tags<CR>


let g:neomake_haskell_enabled_makers = []

" Process management:
nnoremap <Leader>hio :InteroOpen<CR>
nnoremap <Leader>hik :InteroKill<CR>
nnoremap <Leader>hic :InteroHide<CR>
nnoremap <Leader>hil :InteroLoadCurrentModule<CR>
nnoremap <Leader>hif :InteroLoadCurrentFile<CR>
nnoremap <Leader>his :InteroSetTargets<CR>

let g:intero_start_immediately = 0

" REPL commands
nnoremap <Leader>hie :InteroEval<CR>
nnoremap <Leader>hit :InteroGenericType<CR>
nnoremap <Leader>hiT :InteroType<CR>
nnoremap <Leader>hii :InteroInfo<CR>
nnoremap <Leader>hiI :InteroTypeInsert<CR>

" Go to definition:
nnoremap <Leader>hid :InteroGoToDef<CR>

" Highlight uses of identifier:
nnoremap <Leader>hiu :InteroUses<CR>

" Reload the file in Intero after saving

let g:intero_initialized=0

function! s:reload_intero_if_done()
    if g:intero_initialized
        call intero#repl#reload()
    endif
endfunction

autocmd! BufWritePost *.hs call s:reload_intero_if_done()

let g:haskell_indent_if = 3
let g:haskell_indent_case = 5
let g:haskell_indent_let = 4
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 4

let g:haskell_tabular = 1

" Do conceals of wide stuff, like ::, forall, =>, etc.
let g:haskell_conceal_wide = 1
let g:haskell_conceal_bad = 1

let g:haskell_indent_if = 3
let g:haskell_indent_case = 5
let g:haskell_indent_let = 4
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1

setlocal keywordprg=":stack hoogle"

setlocal formatprg=hindent

syntax match hsNiceOperator "\<forall\>" display conceal cchar=∀
syntax match hsNiceOperator "`elem`" conceal cchar=∈
syntax match hsNiceOperator "`notElem`" conceal cchar=∉

syntax match hsStructure
  \ "()"
  \ display conceal cchar=∅

syntax match hsStructure
  \ '\s=>\s'ms=s+1,me=e-1
  \ display conceal cchar=⇒

syntax match hsOperator
  \ '\s\~>\s'ms=s+1,me=e-1
  \ display conceal cchar=⇝

syntax match hsOperator
  \ '\s>>>\s'ms=s+1,me=e-1
  \ display conceal cchar=↠

syntax match hsOperator
  \ '\s<<<\s'ms=s+1,me=e-1
  \ display conceal cchar=↞

syntax match hsStructure
  \ '\s-<\s'ms=s+1,me=e-1
  \ display conceal cchar=↢

syntax match hsStructure
  \ '\s>-\s'ms=s+1,me=e-1
  \ display conceal cchar=↣

syntax match hsStructure
  \ '\s-<<\s'ms=s+1,me=e-1
  \ display conceal cchar=⇺

syntax match hsNiceOperator "\<not\>" conceal cchar=¬
" Enable codex tags if present
set tags=tags;/,codex.tags;/

" Delete trailing whitespace
autocmd BufWritePre *.hs :%s/\s\+$//e"

set tags=tags;/,codex.tags;/

" Let's save undo info!
if !isdirectory($HOME."/.vim-undo")
    call mkdir($HOME."/.vim-undo", "", 0770)
endif
set undodir=~/.vim-undo
set undofile
