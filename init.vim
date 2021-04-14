" ~ general configs ~ "
syntax on
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set exrc
set guicursor=
set nohlsearch
set hidden
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set scrolloff=8
set colorcolumn=80
set signcolumn=yes
filetype plugin indent on
set mouse=a
set relativenumber
set clipboard=unnamed
set cursorline
set numberwidth=1
set encoding=UTF-8
set showcmd
set ruler
set showmatch
set sw=2
set laststatus=2
set backspace=2
set showtabline=2
set noshowmode
set background=dark
let mapleader=" "

" ~ plugins ~ "
" source $HOME/.config/nvim/vim-plug/plugins.vim
call plug#begin('~/.config/nvim/autoload/plugged')
  " Theme
  Plug 'morhetz/gruvbox'
  " Find words or terms in the file
  Plug 'easymotion/vim-easymotion'
  " Better Syntax Support
  Plug 'sheerun/vim-polyglot'
  " File Explorer
  Plug 'scrooloose/NERDTree'
  " Auto pairs for '(' '[' '{'
  Plug 'jiangmiao/auto-pairs'
  " Hotkeys for navigate between files
  Plug 'christoomey/vim-tmux-navigator'
  " Icons
  Plug 'ryanoasis/vim-devicons'
  " Discord Presence
  Plug 'vimsence/vimsence'
  " fzf
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  " Indent
  Plug 'Yggdroot/indentLine'
  " Tabline
  Plug 'itchyny/lightline.vim'
  Plug 'itchyny/vim-gitbranch'
  Plug 'josa42/vim-lightline-coc'
  " Coc
  Plug 'neoclide/coc.nvim', { 'branch':'release' }
  " NerdCommenter
  Plug 'preservim/nerdcommenter'
  " Clap Filer
  Plug 'liuchengxu/vim-clap', { 'do': { -> clap#installer#force_download() } }
  " Rainbow Parenthesis
  Plug 'kien/rainbow_parentheses.vim'
  " Multiple Cursors
  Plug 'mg979/vim-visual-multi', { 'branch': 'master' }
  " Gitlens
  Plug 'APZelos/blamer.nvim'
  " Markdown Preview
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cp app && yarn install' }
  " Utilities
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  " Terminal
  Plug 'voldikss/vim-floaterm'
  " Fern
  Plug 'lambdalisue/fern.vim'
  Plug 'antoinemadec/FixCursorHold.nvim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'lambdalisue/glyph-palette.vim'
  Plug 'lambdalisue/fern-git-status.vim'
call plug#end()

" ~ plugins configs  ~ "
colorscheme gruvbox

let g:gruvbox_contrast_dark="hard"

let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ ["mode", "paste"],
  \             ["gitbranch","readonly","fileformat","filename","modified"] ],
  \   'right': [ ["coc_info","coc_hints","coc_errors","coc_warnings","coc_ok"],["coc_status"] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'gitbranch#name'
  \ },
  \ }

let NERDTreeQuitOnOpen=1

let g:indentLine_char_list=['|','¦']

let g:markdown_fenced_languages = [
  \'vim',
  \'help',
  \]

command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

let g:coc_global_extensions=["coc-emmet","coc-css","coc-html","coc-json","coc-prettier","coc-tsserver","coc-pyright","coc-html-css-support","coc-angular","coc-spell-checker","coc-tailwindcss","coc-vetur"]

let g:clap_popup_cursor_shape       = ''
let g:clap_enable_background_shadow = v:false
let g:clap_current_selection_sign   = { 'text': '» ', 'texthl': 'ClapCurrentSelectionSign', 'linehl': 'ClapCurrentSelection' }
let g:clap_selected_sign            = { 'text': ' »', 'texthl': 'ClapSelectedSign', 'linehl': 'ClapSelected' }
let g:clap_prompt_format            = ' %spinner%%forerunner_status%%provider_id%:'
let g:clap_insert_mode_only   = v:true
let g:clap_disable_run_rooter = v:true
let g:clap_spinner_winid = 1011

nnoremap <leader>b :Clap filer<CR>
nnoremap <leader>c :Clap gfiles<CR>
nnoremap <leader>m :Clap commits<CR>

let g:rbpt_colorpairs = [
    \ ['brown',       'Gold'],
    \ ['Darkblue',    'Orchid'],
    \ ['darkgray',    'LightSkyBlue'],
    \ ['darkgreen',   'Gold'],
    \ ['darkcyan',    'Orchid'],
    \ ['darkred',     'LightSkyBlue'],
    \ ['darkmagenta', 'Gold'],
    \ ['brown',       'Orchid'],
    \ ['gray',        'LightSkyBlue'],
    \ ['black',       'Gold'],
    \ ['darkmagenta', 'Orchid'],
    \ ['Darkblue',    'LightSkyBlue'],
    \ ['darkgreen',   'Gold'],
    \ ['darkcyan',    'Orchid'],
    \ ['darkred',     'LightSkyBlue'],
    \ ['red',         'Gold'],
    \ ]
let g:rbpt_max = 16
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Disable netrw.
let g:loaded_netrw  = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

augroup my-fern-hijack
  autocmd!
  autocmd BufEnter * ++nested call s:hijack_directory()
augroup END

function! s:hijack_directory() abort
  let path = expand('%:p')
  if !isdirectory(path)
    return
  endif
  bwipeout %
  execute printf('Fern %s', fnameescape(path))
endfunction

" Custom settings and mappings.
let g:fern#disable_default_mappings = 1

" not-hidden
let g:fern#default_hidden= 1

" exclude
let g:fern#default_exclude='node_modules'

function! FernInit() abort
  nnoremap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nnoremap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nnoremap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nnoremap <buffer> n <Plug>(fern-action-new-path)
  nnoremap <buffer> d <Plug>(fern-action-remove)
  nnoremap <buffer> t <Plug>(fern-action-trash)
  nnoremap <buffer> m <Plug>(fern-action-move)
  nnoremap <buffer> s <Plug>(fern-action-mark:set)
  nnoremap <buffer> r <Plug>(fern-action-rename)
  nnoremap <buffer> h <Plug>(fern-action-hidden-toggle)
  nnoremap <buffer> R <Plug>(fern-action-reload)
  nnoremap <buffer> y <Plug>(fern-action-yank)
  nnoremap <buffer> b <Plug>(fern-action-open:split)
  nnoremap <buffer> v <Plug>(fern-action-open:vsplit)
  nnoremap <buffer><nowait> u <Plug>(fern-action-leave)
  nnoremap <buffer><nowait> c <Plug>(fern-action-enter)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

" Fixer
let g:cursorhold_updatetime = 100

" Palette
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

" Disable listing ignored files/directories
let g:fern_git_status#disable_ignored = 1

" Disable listing untracked files
let g:fern_git_status#disable_untracked = 1

" Disable listing status of submodules
let g:fern_git_status#disable_submodules = 1

" Disable listing status of directories
let g:fern_git_status#disable_directories = 1

map <silent><C-m> :Fern . -reveal=%<CR>
noremap <leader>n :Fern . -drawer -reveal=% -toggle -width=30<CR><C-w>=

let g:blamer_enabled=1

let g:multi_cursor_use_default_mapping=1

nnoremap <C-s> <Plug>MarkdownPreview
nnoremap <M-s> <Plug>MarkdownPreviewStop
nnoremap <C-p> <Plug>MarkdownPreviewToggle
" ~ aliases ~ "
" // savefile // "
nnoremap <leader>w :w<CR>
" // save&close file // "
nnoremap <leader>wq :wq<CR>
"// close file // "
nnoremap <leader>q :q<CR>
" // active easymotion plugin // "
nmap <leader>s <Plug>(easymotion-s2)
" // active nerdtree plugin // "
nmap <leader>nt :NERDTreeFind<CR>
" // active fzf search files plugin // "
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <leader>h :History<CR>
" // Toggle terminal // "
nnoremap <leader>th :FloatermNew<CR>
