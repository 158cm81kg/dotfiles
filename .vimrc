" ###################################
" Vundle 
" ###################################
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

""""""""""""""""""""
" github
""""""""""""""""""""
Bundle 'thinca/vim-ref'
"webdict site settings
let g:ref_source_webdict_sites = {
\   'je': {
\     'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
\   },
\   'ej': {
\     'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
\   },
\   'wiki': {
\     'url': 'http://ja.wikipedia.org/wiki/%s',
\   },
\ }
 
" default site
let g:ref_source_webdict_sites.default = 'ej'
 
" output filter
function! g:ref_source_webdict_sites.je.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.ej.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.wiki.filter(output)
  return join(split(a:output, "\n")[17 :], "\n")
endfunction

nmap <Leader>rj :<C-u>Ref webdict je<Space>
nmap <Leader>re :<C-u>Ref webdict ej<Space>

Bundle 'thinca/vim-quickrun'

Bundle 'Shougo/unite.vim'

Bundle 'Shougo/neocomplcache'
let g:neocomplcache_enable_at_startup = 1
highlight Pmenu ctermbg=8
highlight PmenuSel ctermbg=1
highlight PmenuSbar ctermbg=0

Bundle 'vim-scripts/yanktmp.vim'
map <silent> sy :call YanktmpYank()<cr>
map <silent> sp :call YanktmpPaste_p()<cr>
map <silent> sP :call YanktmpPaste_P()<cr> 

" ###################################
" default settings
" ###################################
" 構文ごとに色分け表示する
syntax on
"syntax onの場合のコメント文の色を変更する
highlight Comment ctermfg=LightCyan
"新しい行のインデントを現在行と同じにする
"set autoindent
" vim の独自拡張機能を使う[viとの互換性をとらない]
set nocompatible
"タブの代わりに空白文字を挿入する
set expandtab
" 自動認識させる改行コードを指定する
set fileformats=unix,dos
" ウィンドウ枠にタイトルを表示する
set title
" 行番号を表示する
set number
" 検索時、大文字/小文字の区別無視
"set ignorecase
" 大文字小文字を区別して検索
set noic
" 検索強調
set hlsearch
"インクリメンタルサーチを行う
"set incsearch
" 括弧入力時に対応する括弧を強調する
set showmatch
" ウィンドウ幅で行を折り返す
set wrap
" バックスペース対応
set backspace=indent,eol,start
" ファイルの文字コード自動確認
set fileencodings=iso-2022-jp,utf-8,cp932,euc-jp,default,latin
" ウィンドウ枠にタイトルを表示する
set display=uhex
" スクロール時の余白確保
set scrolloff=2
" コマンドラインの高さ
set cmdheight=1
" ステータスラインを常に表示する
set laststatus=2
" 入力中のコマンドをステータスに表示する
set showcmd
" ステータスラインに出力する内容のフォーマット
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\[ENC=%{&fileencoding}]\[TYPE=%Y]\[ASCII=\%03.3b]\[HEX=\%02.2B]\[POS=%04l,%04v][LOW=%l/%L]
"ESC2回押しで、検索ハイライトを消去
:nnoremap <ESC><ESC> :nohlsearch<CR>
"256使用する
set t_Co=256
