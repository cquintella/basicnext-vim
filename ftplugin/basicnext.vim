" Vim filetype plugin
" Language: Basic Next (0.6)
" Version: 0.6.0
" Maintainer: Carlos Quintella
" License: Mozilla Public License Version 2.0

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

setlocal comments=s1:/*,mb:*,ex:*/,://
setlocal commentstring=//\ %s
setlocal formatoptions-=t formatoptions+=croql

" Omnifunc autocomplete (ALLCAPS reserved words, types and builtins)
setlocal omnifunc=basicnext#Complete

" Formatting expression for 'gq'
setlocal formatexpr=basicnext#FormatExpr()

" Auto-caps on typing (abbreviations for reserved words)
if get(g:, 'basicnext_auto_caps', 1)
  call basicnext#SetupAutoCaps()
endif

" Matchit navigation
if !exists("g:no_plugin_maps") && (exists("loaded_matchit") || exists("g:loaded_matchit"))
  let b:match_ignorecase = 0
  let b:match_words =
        \ '\<IF\>:\<ELSE\>:\<END\s\+IF\>,' .
        \ '\<WHILE\>:\<END\s\+WHILE\>,' .
        \ '\<FOR\>:\<END\s\+FOR\>,' .
        \ '\<REPEAT\>:\<UNTIL\>,' .
        \ '\<FUNCTION\>:\<END\s\+FUNCTION\>,' .
        \ '\<CONSTRUCTOR\>:\<END\s\+CONSTRUCTOR\>,' .
        \ '\<DESTRUCTOR\>:\<END\s\+DESTRUCTOR\>,' .
        \ '\<CLASS\>:\<END\s\+CLASS\>,' .
        \ '\<STRUCT\>:\<END\s\+STRUCT\>,' .
        \ '\<INTERFACE\>:\<END\s\+INTERFACE\>'
endif

" Set default compiler to bni if none set
if !exists("b:current_compiler")
  compiler bni
endif

" Buffer-local commands
command! -buffer -bang -nargs=* BasicNextRun execute '!bni run ' . expand('%:p') . ' ' . <q-args>
command! -buffer -bang -nargs=* BasicNextCheck execute '!bni check ' . expand('%:p') . ' ' . <q-args>
command! -buffer -bang -bar BnFormat call basicnext#Format()
command! -buffer -bang -bar BNFormat call basicnext#Format()
command! -buffer -bang -bar BasicNextFormat call basicnext#Format()

let b:undo_ftplugin = "setlocal comments< commentstring< formatoptions< omnifunc< formatexpr<"
      \ . " | unlet! b:match_words b:match_ignorecase"
      \ . " | silent! delcommand BasicNextRun"
      \ . " | silent! delcommand BasicNextCheck"
      \ . " | silent! delcommand BnFormat"
      \ . " | silent! delcommand BNFormat"
      \ . " | silent! delcommand BasicNextFormat"

let &cpo = s:cpo_save
unlet s:cpo_save
