call plug#begin('~/.local/share/nvim/plugged')
  Plug 'jiangmiao/auto-pairs'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'vim-airline/vim-airline'
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'ryanoasis/vim-devicons'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'morhetz/gruvbox'
  Plug 'stsewd/spotify.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
call plug#end()

syntax on
colorscheme tokyonight-night
set tabstop=4
set shiftwidth=4
set expandtab
set relativenumber
set encoding=utf-8
set clipboard=unnamedplus
filetype plugin indent on
" Set C++ file type
autocmd BufNewFile,BufRead *.cpp set filetype=cpp
nmap <C-n> :NERDTreeToggle<CR> 
" Compile and run C++ program in subshell
nnoremap <silent> <buffer> <F5> :call <SID>compile_run_cpp()<CR>

function! s:compile_run_cpp() abort
  let src_path = expand('%:p:~')
  let src_noext = expand('%:p:~:r')
  " The building flags
  let _flag = '-Wall -Wextra -std=c++11 -O2'

  if executable('clang++')
    let prog = 'clang++'
  elseif executable('g++')
    let prog = 'g++'
  else
    echoerr 'No compiler found!'
  endif
  call s:create_term_buf('v', 80)
  execute printf('term %s %s %s -o %s && %s', prog, _flag, src_path, src_noext, src_noext)
  startinsert
endfunction

function s:create_term_buf(_type, size) abort
  set splitbelow
  set splitright
  if a:_type ==# 'v'
    vnew
  else
    new
  endif
  execute 'resize ' . a:size
endfunction
 

noremap <C-p> :FZF<CR>

source ~/.config/nvim/coc.vim

let g:clipboard = {
    \   'name': 'WslClipboard',
    \   'copy': {
    \      '+': 'clip.exe',
    \      '*': 'clip.exe',
    \    },
    \   'paste': {
    \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    \   },
    \   'cache_enabled': 0,
    \ }
let g:spotify_symbols = {
    \ "playing": "▶",
    \ "paused": "⏸",
    \ "stopped": "■",
    \ "volume.high": "🔊",
    \ "volume.medium": "🔉",
    \ "volume.low":  "🔈",
    \ "volume.muted": "🔇",
    \ "shuffle.enabled": "⤮ on",
    \ "shuffle.disabled": "⤮ off",
    \ "progress.mark": "●",
    \ "progress.complete": "─",
    \ "progress.missing": "┈",
    \}

" g:spotify_show_status = 1
let g:airline_powerline_fonts = 1

