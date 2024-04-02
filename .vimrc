syntax on
filetype on
filetype plugin indent on

set tabstop=2 softtabstop=2 
set number relativenumber
set shiftwidth=2
set expandtab
set smartindent
set nowrap
set incsearch
set ignorecase
set smartcase
"Makes the annoying bell sound go away when sshing from windows
set visualbell
set t_vb=

"Indent with 4 spaces in haskell
autocmd BufRead,BufNewFile *.hs setlocal shiftwidth=2 softtabstop=4 expandtab

let g:agda_extraincpaths = ["/home/gustavo/Desktop/"]

"Always wrap text in the quickfix window
augroup quickfix
    autocmd!
    autocmd FileType qf setlocal wrap
augroup END

"Remap jk or kj to <Esc> in insert mode
inoremap jk <Esc>
inoremap kj <Esc>
inoremap JK <Esc>
inoremap KJ <Esc>

"Quicker tab navigation
nnoremap K gt
nnoremap J gT

"Quicker window switching
nnoremap H h
nnoremap L l

"Substitute the default J with M
nnoremap M J

"Auto close parenthesis and brackets
"inoremap " ""<left>
"inoremap ' ''<left>
"nnoremap ( ()<left>
"nnoremap [ []<left>
"nnoremap { {}<left>
"nnoremap {<CR> {<CR>}<ESC>O
"nnoremap {;<CR> {<CR>};<ESC>O

"Use <Space>p to load the hierarchical editing plugin (Useful for quick debugging)
"nnoremap <Space>p :source /home/gustavo/Desktop/Python/ast/Structured-Editor-For-Python/plugin.vim<Enter>

let mapleader = ","
let maplocalleader = " "

"Opens the file that defines the data type the cursor is on top of 
"It finds it by grepping over the libs directory
function IdrisGoToDefinition()
  let command = 'find ~/Desktop/Source/Idris2/libs -name "*.idr" | xargs grep "data ' . expand('<cword>') . '" | awk -F ":" ''{print $1}'' | cut -d/ -f 8- | head -n 1'
  echom command
  let file = system(command)
  echom file
  execute "sp " . "~/Desktop/Source/Idris2/libs/" . file
endfunction

"Adds the line below the haskell function signature with the function name
nnoremap <LocalLeader>h 0yawo<Esc>pA=<Esc>hi

" Haskell auto formatter
" https://github.com/jaspervdj/stylish-haskell

" Run in on the whole file
nnoremap <LocalLeader>q :%!stylish-haskell<Enter>

" Run it on the selected lines
" TODO: Enable this only on haskell files
" set formatprg=stylish-haskell

" Source the file telling vim to replace the idris2 command with idris2dev if
" necessary (useful for hacking on idris)
" https://unix.stackexchange.com/questions/550622/how-to-run-aliases-commands-in-inside-the-vim-editor
" let $BASH_ENV = "~/.vim_bash_env"

" Convenient window resizing
nnoremap + +
nnoremap - -

"function MyIdrisGoToDefinition()
"  let functionNameWithNamespaces = expand('<cWORD>')
"  echo functionNameWithNamespaces
"
"  " Substitute dots with forward slashes
"  let path = substitute(functionNameWithNamespaces, ".", "/", "g")
"  execute ":tabe " . path
"
"endfunction
"
"nnoremap <LocalLeader>j MyIdrisGoToDefinition()

function Writing()
  set wrap
  set linebreak
endfunction

" Not perfect but will do
function DartFormatCurrentFile()
  " Make sure the process won't move the cursor or scroll the screen
  let view = winsaveview()

  w
  silent exec "!dart format %"
  e!
  redraw!

  call winrestview(view)

endfunction

function RunHaskellMain()
  w
  !ghc -Wall Main.hs && ./Main
endfunction

function CabalRun()
  w
  !cabal run
endfunction

" TODO: Set this just in Dart files
" nnoremap <LocalLeader>f :call DartFormatCurrentFile()<CR>

" nnoremap <LocalLeader>g :call RunHaskellMain()<CR>
nnoremap <LocalLeader>g :call CabalRun()<CR>

" Some configuration options suggested by CoC at
" https://github.com/neoclide/coc.nvim#example-vim-configuration

set encoding=utf-8
set hidden
set updatetime=300

if v:version >= 802
  set signcolumn=number
endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nnoremap gh :call CocActionAsync('showIncomingCalls')<CR>
vmap <LocalLeader>f  <Plug>(coc-format-selected)
nmap <LocalLeader>a  <Plug>(coc-codeaction-cursor)
nnoremap <silent> gH :call <SID>show_documentation()<CR>
nmap <LocalLeader>rn <Plug>(coc-rename)
" nnoremap <LocalLeader>r :CocRestart<Enter>

" Change the color of HLint suggestion windows' text to something more
" readable
highlight CocFloating ctermbg=242
highlight CocErrorFloat ctermfg=LightRed

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
