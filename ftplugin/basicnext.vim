" Vim filetype plugin
" Language: Basic Next (0.6)
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

let b:undo_ftplugin = "setlocal comments< commentstring< formatoptions<"
      \ . " | unlet! b:match_words b:match_ignorecase"
      \ . " | silent! delcommand BasicNextRun"
      \ . " | silent! delcommand BasicNextCheck"

let &cpo = s:cpo_save
unlet s:cpo_save
